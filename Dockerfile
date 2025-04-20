# ---------- Stage 1: Build ----------
    FROM node:18 AS builder

    WORKDIR /app
    COPY package*.json ./
    RUN npm install
    
    # Copy only the code after installing dependencies
    COPY . .
    
    # ---------- Stage 2: Runtime ----------
    FROM node:18-slim
    
    WORKDIR /app
    
    # Copy only built code & installed modules from builder
    COPY --from=builder /app /app
    COPY --from=builder /app/node_modules /app/node_modules
    
    EXPOSE 3000
    CMD ["node", "app.js"]
    