# CS61C 学习计划

> 最后更新：2026-02-09  
> 当前进度：Lecture 15 完成，准备开始数字逻辑部分

---

## 📍 当前状态

### ✅ 已完成

- **Part 1: C 语言** (Lecture 1-5)
  - Lab 00, 01, 02 ✓
  - Project 1: Snake Game ✓

- **Part 2: RISC-V 汇编** (Lecture 6-15)
  - Lab 03, 04 ✓
  - Project 2: Classify ✓
    - relu.s, argmax.s, dot.s, matmul.s ✓
    - read_matrix.s, write_matrix.s ✓
    - classify.s ✓
    - studenttests.py ✓

### 🎯 当前位置

- **Lecture 15**: RISC-V Calling Conventions 刚完成
- **下一步**: Lecture 16 - Intro to SDS (同步数字系统)

---

## 📚 后续学习路线图

### **阶段 3: 数字逻辑与硬件设计** (Week 6-8, 约 3-4 周)

#### Lecture 16-18: 数字逻辑基础
- **Lecture 16**: Intro to SDS (同步数字系统)
- **Lecture 17**: Combinational Logic (组合逻辑)
- **Lecture 18**: State (状态机、时序逻辑)

**学习资源**：
- 📖 教材：P&H Appendix B.2-B.8 (The Basics of Logic Design)
- 💻 练习：HDLBits 网站 (https://hdlbits.01xz.net/) 前 50 题
- 🛠️ 工具：Logisim Evolution

**Lab 05**: 数字逻辑与 Logisim
- 📁 位置：`/Users/huangkai/workdir/lec/cs61c-fa25/labs/lab05/`
- 内容：
  - ex2.circ - 组合逻辑练习
  - ex3.circ - 时序逻辑
  - ex4.circ - 状态机

**学习重点**：
- [ ] 理解逻辑门（AND, OR, NOT, XOR）
- [ ] 掌握组合逻辑（MUX, 加法器, ALU）
- [ ] 理解时序逻辑（触发器, 寄存器）
- [ ] 掌握有限状态机（FSM）

**预计时间**：1-2 周

---

### **阶段 4: 处理器设计** (Week 8-10, 约 3-4 周)

#### Lecture 19-25: CPU 设计与流水线
- **Lecture 19-20**: Datapath (数据通路设计)
- **Lecture 21-22**: Control (控制单元)
- **Lecture 23-24**: Pipelining (流水线)
- **Lecture 25**: Hazards (冒险处理)

**学习资源**：
- 📖 教材：P&H Chapter 4 (The Processor)
  - 4.1-4.3: Building a Datapath (必读)
  - 4.4: A Simple Implementation (必读)
  - 4.5-4.9: Pipelining (重点)
- 🎥 视频：CS61C 官方录播

**Lab 06**: 寄存器文件与时序逻辑
- 内容：实现寄存器文件、状态机

**Project 3**: 单周期 RISC-V CPU ⭐ 重点项目
- 📁 位置：`/Users/huangkai/workdir/lec/cs61c-fa25/projects/proj3/` (待创建)
- 内容：
  - 用 Logisim 设计完整的单周期 RISC-V CPU
  - 实现 R-type, I-type, S-type, B-type 指令
  - 数据通路 + 控制单元
  - 支持基本的 RISC-V 指令集

**学习重点**：
- [ ] 理解 CPU 数据通路的各个组件
- [ ] 掌握控制信号的生成逻辑
- [ ] 理解流水线的工作原理
- [ ] 掌握数据冒险和控制冒险的处理

**预计时间**：3-4 周

---

### **阶段 5: 内存层次结构** (Week 11-12, 约 2-3 周)

#### Lecture 26-30: Cache 与虚拟内存
- **Lecture 26-27**: Caches (缓存基础)
- **Lecture 28**: Cache Performance (缓存性能)
- **Lecture 29**: Virtual Memory (虚拟内存)
- **Lecture 30**: VM & TLB (页表与 TLB)

**学习资源**：
- 📖 教材：P&H Chapter 5 (Memory Hierarchy)
  - 5.1-5.3: Cache Basics (必读)
  - 5.4: Measuring Cache Performance (必读)
  - 5.7-5.8: Virtual Memory (重点)
- 📖 补充：CSAPP Chapter 6 (Cache) 和 Chapter 9 (Virtual Memory)

**Lab 07**: Cache 模拟器
- 内容：实现简单的 Cache 模拟器

**学习重点**：
- [ ] 理解内存层次结构（寄存器、Cache、内存、磁盘）
- [ ] 掌握 Cache 的工作原理（直接映射、组相联、全相联）
- [ ] 理解 Cache 性能指标（命中率、缺失率、AMAT）
- [ ] 掌握虚拟内存和页表的概念
- [ ] 理解 TLB 的作用

**预计时间**：2-3 周

---

### **阶段 6: 并行计算** (Week 13-14, 约 2 周)

#### Lecture 31-33: 并行与现代架构
- **Lecture 31**: Thread-Level Parallelism (线程级并行)
- **Lecture 32**: OpenMP, SIMD (并行编程)
- **Lecture 33**: Warehouse-Scale Computing (数据中心)

**学习资源**：
- 📖 教材：P&H Chapter 6 (Parallel Processors)
- 🎥 视频：CS61C 并行计算讲座

**Lab 08**: OpenMP 并行编程
- 📁 位置：`/Users/huangkai/workdir/lec/cs61c-fa25/labs/lab07/`
- 内容：使用 OpenMP 加速程序

**Project 4**: 性能优化 (可选)
- 内容：使用 SIMD、OpenMP 等技术优化矩阵运算

**学习重点**：
- [ ] 理解多核处理器架构
- [ ] 掌握 OpenMP 并行编程
- [ ] 了解 SIMD 指令
- [ ] 理解并行程序的性能分析

**预计时间**：2 周

---

## 📖 教材阅读计划

### **Computer Organization and Design: RISC-V Edition** (P&H)

| 周数 | 章节 | 内容 | 优先级 |
|------|------|------|--------|
| Week 6-7 | Appendix B.2-B.8 | 数字逻辑基础 | ⭐⭐⭐ 必读 |
| Week 8-10 | Chapter 4.1-4.8 | 处理器设计与流水线 | ⭐⭐⭐ 必读 |
| Week 11-12 | Chapter 5.1-5.4, 5.7-5.8 | Cache 与虚拟内存 | ⭐⭐⭐ 必读 |
| Week 13-14 | Chapter 6.1-6.6 | 并行处理器 | ⭐⭐ 推荐 |

**阅读建议**：
- 每周提前预习对应章节（2-3 小时）
- 配合 Lecture 视频理解概念
- 做章节后的习题巩固（至少 50%）

---

## 🛠️ 工具与环境

### **已配置**
- ✅ RISC-V 工具链（Venus, RISC-V GNU Toolchain）
- ✅ Java 17 (SDKMAN)
- ✅ Python 环境

### **待安装**（数字逻辑部分需要）
- [ ] Logisim Evolution
  ```bash
  brew install --cask logisim-evolution
  ```
- [ ] Verilog 仿真工具（可选，如果想深入学习）
  ```bash
  brew install icarus-verilog gtkwave
  ```

### **学习环境**
- 📁 数字逻辑学习环境：`/Users/huangkai/workdir/lec/digital-logic-learning/`
  - 已创建完整的 Verilog 学习环境
  - 包含示例代码、测试框架、Makefile
  - 详见 `QUICKSTART.md` 和 `RESOURCES.md`

---

## 📝 学习建议

### **时间分配**（每周 10-15 小时）
```
理论学习（教材 + 视频）：    4-5 小时
Lab 练习：                   3-4 小时
Project 实践：               4-6 小时
复习与总结：                 1-2 小时
```

### **学习方法**

1. **预习 → 听课 → 实践 → 复习**
   - 提前看教材对应章节（1-2 小时）
   - 看 Lecture 视频或 slides（1 小时）
   - 做 Lab 和 Project（4-8 小时）
   - 总结重点概念（30 分钟）

2. **理论与实践结合**
   - 不要只看不做
   - 每个概念都要在 Logisim 或代码中实现
   - 遇到问题先自己调试，再查资料

3. **循序渐进**
   - 不要跳过基础内容
   - 确保理解了再继续
   - 遇到困难可以放慢进度

4. **记录学习笔记**
   - 记录重点概念和易错点
   - 记录调试过程和解决方案
   - 定期回顾笔记

---

## 🌐 在线资源

### **课程资源**
- 📚 CS61C 官网: https://cs61c.org/fa25/
- 🎥 CS61C YouTube: 搜索 "CS61C" 找往年录播
- 📖 P&H 教材: Computer Organization and Design (RISC-V Edition)

### **练习平台**
- 💻 HDLBits: https://hdlbits.01xz.net/ (Verilog 练习)
- 🎮 Nand2Tetris: https://www.nand2tetris.org/ (从逻辑门到计算机)

### **参考资料**
- 📚 CSAPP (CMU 15-213): 补充阅读，尤其是 Cache 和虚拟内存部分
- 📚 CS自学指南: https://csdiy.wiki/ (中文学习路线)

### **社区与论坛**
- 💬 CS61C Piazza/Ed: 课程论坛
- 💬 Stack Overflow: 标签 [risc-v], [logisim], [computer-architecture]
- 💬 Reddit r/FPGA: 硬件设计社区

---

## ✅ 检查清单

### **开始数字逻辑部分前**
- [ ] 阅读 P&H Appendix B.2-B.5（组合逻辑）
- [ ] 安装 Logisim Evolution
- [ ] 熟悉 Logisim 基本操作（30 分钟）
- [ ] 完成 HDLBits 前 10 题（熟悉基本逻辑）

### **开始 Lab 05 前**
- [ ] 理解 MUX、加法器、ALU 的工作原理
- [ ] 在 Logisim 中实现简单的 MUX2 和 MUX4
- [ ] 阅读 Lab 05 说明文档

### **开始 Project 3 前**
- [ ] 完成 Lab 05 和 Lab 06
- [ ] 阅读 P&H Chapter 4.1-4.4（单周期 CPU）
- [ ] 理解 RISC-V 指令格式和数据通路
- [ ] 在 Logisim 中实现简单的 ALU 和寄存器文件

---

## 📅 建议时间表

### **Week 6-7: 数字逻辑** (2 周)
```
Week 6:
- Day 1-2: 阅读 P&H Appendix B, 看 Lecture 16-17
- Day 3-4: 学习 Logisim, 做 HDLBits 前 30 题
- Day 5-7: 完成 Lab 05 (ex2, ex3)

Week 7:
- Day 1-2: 看 Lecture 18, 阅读状态机相关内容
- Day 3-4: 完成 Lab 05 (ex4), 做 HDLBits 31-50 题
- Day 5-7: 复习总结，准备 Lab 06
```

### **Week 8-10: 处理器设计** (3 周)
```
Week 8:
- Day 1-2: 阅读 P&H Chapter 4.1-4.3, 看 Lecture 19-20
- Day 3-5: 完成 Lab 06
- Day 6-7: 开始 Project 3 (设计数据通路)

Week 9:
- Day 1-3: 阅读 P&H Chapter 4.4, 看 Lecture 21-22
- Day 4-7: Project 3 (实现控制单元和基本指令)

Week 10:
- Day 1-2: 阅读 P&H Chapter 4.5-4.8, 看 Lecture 23-25
- Day 3-7: 完成 Project 3, 测试和调试
```

### **Week 11-12: 内存层次** (2 周)
```
Week 11:
- Day 1-2: 阅读 P&H Chapter 5.1-5.4, 看 Lecture 26-28
- Day 3-7: 完成 Lab 07 (Cache 模拟器)

Week 12:
- Day 1-2: 阅读 P&H Chapter 5.7-5.8, 看 Lecture 29-30
- Day 3-5: 完成虚拟内存相关练习
- Day 6-7: 复习 Cache 和虚拟内存
```

### **Week 13-14: 并行计算** (2 周)
```
Week 13:
- Day 1-2: 阅读 P&H Chapter 6.1-6.3, 看 Lecture 31
- Day 3-7: 完成 Lab 08 (OpenMP)

Week 14:
- Day 1-2: 看 Lecture 32-33, 了解 SIMD 和 WSC
- Day 3-5: Project 4 (可选)
- Day 6-7: 总复习，整理笔记
```

---

## 🎯 学习目标

### **短期目标** (2-4 周)
- [ ] 完成数字逻辑部分（Lecture 16-18）
- [ ] 掌握 Logisim 的使用
- [ ] 完成 Lab 05 和 Lab 06
- [ ] 理解组合逻辑和时序逻辑

### **中期目标** (4-8 周)
- [ ] 完成处理器设计部分（Lecture 19-25）
- [ ] 完成 Project 3（单周期 RISC-V CPU）
- [ ] 深入理解 CPU 的工作原理
- [ ] 掌握流水线和冒险处理

### **长期目标** (8-12 周)
- [ ] 完成整个 CS61C 课程
- [ ] 理解计算机体系结构的核心概念
- [ ] 掌握从逻辑门到完整计算机的设计
- [ ] 为学习操作系统打下坚实基础

---

## 📌 重要提醒

### **学习心态**
- ⏰ 不要急于求成，理解比速度重要
- 🔄 遇到困难是正常的，坚持下去
- 💪 动手实践比看视频重要 10 倍
- 📝 记录学习过程，定期回顾

### **常见问题**
- **Q: 数字逻辑部分很抽象，怎么办？**
  - A: 多在 Logisim 中动手实践，看波形图理解时序
  
- **Q: Project 3 太难了，做不出来？**
  - A: 先完成 Lab 05-06，理解基础组件，再逐步构建 CPU
  
- **Q: 时间不够，可以跳过某些内容吗？**
  - A: 不建议跳过，每个部分都很重要，可以放慢进度

### **并行学习操作系统**
如果想同时学习操作系统（之前讨论过）：
- 建议等完成 CS61C 的 Cache 和虚拟内存部分后再开始
- 两门课的内存管理部分会互相加深理解
- 时间分配：CS61C 60%, OS 40%

---

## 📞 获取帮助

- 🤖 随时问我问题（AI 助手）
- 💬 CS61C 课程论坛
- 🔍 Stack Overflow
- 📚 查阅 P&H 教材和 CSAPP

---

## 📝 学习记录

### **学习日志**（建议记录）
```
日期：____
学习内容：____
完成进度：____
遇到的问题：____
解决方案：____
下次计划：____
```

### **进度追踪**
- 当前 Lecture: 15
- 已完成 Lab: 00, 01, 02, 03, 04
- 已完成 Project: 1, 2
- 下一个里程碑: Lab 05

---

## 🎉 加油！

你已经完成了 CS61C 的前半部分（C 语言和 RISC-V 汇编），这是非常扎实的基础！

接下来的数字逻辑和处理器设计部分会更有挑战性，但也更有趣。当你亲手在 Logisim 中设计出一个能运行程序的 CPU 时，那种成就感是无与伦比的！

**记住**：
- 💡 理解原理比记住细节重要
- 🔧 动手实践比看视频重要
- 🐌 慢慢来，每一步都走扎实
- 🎯 目标是理解计算机如何工作，而不是赶进度

祝学习顺利！有任何问题随时来找我 😊

---

> 最后更新：2026-02-09  
> 下次学习时，从 **Lecture 16** 和 **Lab 05** 开始！
