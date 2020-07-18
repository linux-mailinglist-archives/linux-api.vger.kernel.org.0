Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF86224C6B
	for <lists+linux-api@lfdr.de>; Sat, 18 Jul 2020 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgGRPXs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 18 Jul 2020 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRPXs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 18 Jul 2020 11:23:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34554C0619D2
        for <linux-api@vger.kernel.org>; Sat, 18 Jul 2020 08:23:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l63so8131811pge.12
        for <linux-api@vger.kernel.org>; Sat, 18 Jul 2020 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+ONhxBTblwPBJIwiwhiRVXmV2h7O7tyLU69EhakOJc=;
        b=QbL0M6X69D0IPDSkwVfjt5Rzffv1SGnKub0O9Os0P5jtz94+7SIpzjFSRo38JVsHS9
         Z3uJ7NL/Vd1RovYiFQUuQkS7fPi2RkPwYjTPabcYMYTQE3CIimYDFp0H8AYc2G9CYcIP
         1bGmOR78vwweZCwl5MChggqvO+3XbJPPdOqEx3Fx7UWMPEiwfy2gpvZSVet9anGiMoZX
         gMQ916bF/nGrgMCFtIcvOnnFc5UaENOmegKfSvSa4gemcPbxi6G6ffJZZn6PpEpx3qSX
         hm4sVynIMPLh2E9h1yoZTSp3gzZFe0W1LVMNhIQnZsIlpuJOpCU9F3q659tw6oku8fyO
         oM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+ONhxBTblwPBJIwiwhiRVXmV2h7O7tyLU69EhakOJc=;
        b=iFmWhPGdcXpMjQdRphWUNFlc58yTqcLkVIlohqmes9uyPQANMgmoPT8Gjg3F2vw+zW
         Cj3Ttxkmxjpj8Igi8mW4jgvfajzMbsv7HHuf2AM2eLQD+MBL0IqANVX8Z7JGyYq+99Cb
         6VL5Qi2qs406aZiSKohg7OPK6ihJ3yXIsFHpoDn2qDQwDyqhKiOBu1WmXIYTwqGVFDVe
         BwgFhwoUehN+G78MD1rjTAgTkzBa5lhnVxLcP8PGjwq0uUPqRXt/deZp1QAVSkh3iCIx
         ABVkKOzuCMOJIgBWYFO+Yi+ruQb4PykIkCjcI1XOokU7cung4XHR8mengd85flUodyo0
         PaUw==
X-Gm-Message-State: AOAM533gPbEce9BwpphQrbIiVj6508nOOQ2E0vV2ch28RzbqxmR3sqq2
        pjDjoxu1Lj5yts03qz3ORXU=
X-Google-Smtp-Source: ABdhPJzYKCzZ5HwW059dHnLR5pVMbdoq6UzVxemAWbbg+RQyxymC8o7R5iytbAN4oGqImaJHaxxc4g==
X-Received: by 2002:aa7:9117:: with SMTP id 23mr12354011pfh.264.1595085827568;
        Sat, 18 Jul 2020 08:23:47 -0700 (PDT)
Received: from linux-kernel-source.asia-southeast1-b.c.hardy-notch-265411.internal (3.136.240.35.bc.googleusercontent.com. [35.240.136.3])
        by smtp.gmail.com with ESMTPSA id h15sm11067808pfo.192.2020.07.18.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 08:23:47 -0700 (PDT)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     tglx@linutronix.de, trivial@kernel.org
Cc:     linux-api@vger.kernel.org,
        Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH] syscalls.h: Remove all file references in comments
Date:   Sat, 18 Jul 2020 15:23:22 +0000
Message-Id: <20200718152322.4429-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718152322.4429-1-minhquangbui99@gmail.com>
References: <20200718150847.4052-2-minhquangbui99@gmail.com>
 <20200718152322.4429-1-minhquangbui99@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

File references may be incorrect when things change.
So remove them completely.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
AAAAA
 include/linux/syscalls.h | 134 ++++-----------------------------------
 1 file changed, 14 insertions(+), 120 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..0e320400cf0a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -321,8 +321,6 @@ asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
 				const sigset_t __user *sig, size_t sigsz);
 asmlinkage long sys_io_uring_register(unsigned int fd, unsigned int op,
 				void __user *arg, unsigned int nr_args);
-
-/* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
 			     const void __user *value, size_t size, int flags);
 asmlinkage long sys_lsetxattr(const char __user *path, const char __user *name,
@@ -345,17 +343,9 @@ asmlinkage long sys_removexattr(const char __user *path,
 asmlinkage long sys_lremovexattr(const char __user *path,
 				 const char __user *name);
 asmlinkage long sys_fremovexattr(int fd, const char __user *name);
-
-/* fs/dcache.c */
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
-
-/* fs/cookies.c */
 asmlinkage long sys_lookup_dcookie(u64 cookie64, char __user *buf, size_t len);
-
-/* fs/eventfd.c */
 asmlinkage long sys_eventfd2(unsigned int count, int flags);
-
-/* fs/eventpoll.c */
 asmlinkage long sys_epoll_create1(int flags);
 asmlinkage long sys_epoll_ctl(int epfd, int op, int fd,
 				struct epoll_event __user *event);
@@ -363,8 +353,6 @@ asmlinkage long sys_epoll_pwait(int epfd, struct epoll_event __user *events,
 				int maxevents, int timeout,
 				const sigset_t __user *sigmask,
 				size_t sigsetsize);
-
-/* fs/fcntl.c */
 asmlinkage long sys_dup(unsigned int fildes);
 asmlinkage long sys_dup3(unsigned int oldfd, unsigned int newfd, int flags);
 asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
@@ -373,24 +361,15 @@ asmlinkage long sys_fcntl64(unsigned int fd,
 				unsigned int cmd, unsigned long arg);
 #endif
 
-/* fs/inotify_user.c */
 asmlinkage long sys_inotify_init1(int flags);
 asmlinkage long sys_inotify_add_watch(int fd, const char __user *path,
 					u32 mask);
 asmlinkage long sys_inotify_rm_watch(int fd, __s32 wd);
-
-/* fs/ioctl.c */
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
 				unsigned long arg);
-
-/* fs/ioprio.c */
 asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
 asmlinkage long sys_ioprio_get(int which, int who);
-
-/* fs/locks.c */
 asmlinkage long sys_flock(unsigned int fd, unsigned int cmd);
-
-/* fs/namei.c */
 asmlinkage long sys_mknodat(int dfd, const char __user * filename, umode_t mode,
 			    unsigned dev);
 asmlinkage long sys_mkdirat(int dfd, const char __user * pathname, umode_t mode);
@@ -401,18 +380,12 @@ asmlinkage long sys_linkat(int olddfd, const char __user *oldname,
 			   int newdfd, const char __user *newname, int flags);
 asmlinkage long sys_renameat(int olddfd, const char __user * oldname,
 			     int newdfd, const char __user * newname);
-
-/* fs/namespace.c */
 asmlinkage long sys_umount(char __user *name, int flags);
 asmlinkage long sys_mount(char __user *dev_name, char __user *dir_name,
 				char __user *type, unsigned long flags,
 				void __user *data);
 asmlinkage long sys_pivot_root(const char __user *new_root,
 				const char __user *put_old);
-
-/* fs/nfsctl.c */
-
-/* fs/open.c */
 asmlinkage long sys_statfs(const char __user * path,
 				struct statfs __user *buf);
 asmlinkage long sys_statfs64(const char __user *path, size_t sz,
@@ -443,20 +416,12 @@ asmlinkage long sys_openat2(int dfd, const char __user *filename,
 			    struct open_how *how, size_t size);
 asmlinkage long sys_close(unsigned int fd);
 asmlinkage long sys_vhangup(void);
-
-/* fs/pipe.c */
 asmlinkage long sys_pipe2(int __user *fildes, int flags);
-
-/* fs/quota.c */
 asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
 				qid_t id, void __user *addr);
-
-/* fs/readdir.c */
 asmlinkage long sys_getdents64(unsigned int fd,
 				struct linux_dirent64 __user *dirent,
 				unsigned int count);
-
-/* fs/read_write.c */
 asmlinkage long sys_llseek(unsigned int fd, unsigned long offset_high,
 			unsigned long offset_low, loff_t __user *result,
 			unsigned int whence);
@@ -479,12 +444,8 @@ asmlinkage long sys_preadv(unsigned long fd, const struct iovec __user *vec,
 			   unsigned long vlen, unsigned long pos_l, unsigned long pos_h);
 asmlinkage long sys_pwritev(unsigned long fd, const struct iovec __user *vec,
 			    unsigned long vlen, unsigned long pos_l, unsigned long pos_h);
-
-/* fs/sendfile.c */
 asmlinkage long sys_sendfile64(int out_fd, int in_fd,
 			       loff_t __user *offset, size_t count);
-
-/* fs/select.c */
 asmlinkage long sys_pselect6(int, fd_set __user *, fd_set __user *,
 			     fd_set __user *, struct __kernel_timespec __user *,
 			     void __user *);
@@ -497,19 +458,13 @@ asmlinkage long sys_ppoll(struct pollfd __user *, unsigned int,
 asmlinkage long sys_ppoll_time32(struct pollfd __user *, unsigned int,
 			  struct old_timespec32 __user *, const sigset_t __user *,
 			  size_t);
-
-/* fs/signalfd.c */
 asmlinkage long sys_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask, int flags);
-
-/* fs/splice.c */
 asmlinkage long sys_vmsplice(int fd, const struct iovec __user *iov,
 			     unsigned long nr_segs, unsigned int flags);
 asmlinkage long sys_splice(int fd_in, loff_t __user *off_in,
 			   int fd_out, loff_t __user *off_out,
 			   size_t len, unsigned int flags);
 asmlinkage long sys_tee(int fdin, int fdout, size_t len, unsigned int flags);
-
-/* fs/stat.c */
 asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
 			       int bufsiz);
 asmlinkage long sys_newfstatat(int dfd, const char __user *filename,
@@ -521,7 +476,6 @@ asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
 			       struct stat64 __user *statbuf, int flag);
 #endif
 
-/* fs/sync.c */
 asmlinkage long sys_sync(void);
 asmlinkage long sys_fsync(unsigned int fd);
 asmlinkage long sys_fdatasync(unsigned int fd);
@@ -529,8 +483,6 @@ asmlinkage long sys_sync_file_range2(int fd, unsigned int flags,
 				     loff_t offset, loff_t nbytes);
 asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 					unsigned int flags);
-
-/* fs/timerfd.c */
 asmlinkage long sys_timerfd_create(int clockid, int flags);
 asmlinkage long sys_timerfd_settime(int ufd, int flags,
 				    const struct __kernel_itimerspec __user *utmr,
@@ -541,39 +493,25 @@ asmlinkage long sys_timerfd_gettime32(int ufd,
 asmlinkage long sys_timerfd_settime32(int ufd, int flags,
 				   const struct old_itimerspec32 __user *utmr,
 				   struct old_itimerspec32 __user *otmr);
-
-/* fs/utimes.c */
 asmlinkage long sys_utimensat(int dfd, const char __user *filename,
 				struct __kernel_timespec __user *utimes,
 				int flags);
 asmlinkage long sys_utimensat_time32(unsigned int dfd,
 				const char __user *filename,
 				struct old_timespec32 __user *t, int flags);
-
-/* kernel/acct.c */
 asmlinkage long sys_acct(const char __user *name);
-
-/* kernel/capability.c */
 asmlinkage long sys_capget(cap_user_header_t header,
 				cap_user_data_t dataptr);
 asmlinkage long sys_capset(cap_user_header_t header,
 				const cap_user_data_t data);
-
-/* kernel/exec_domain.c */
 asmlinkage long sys_personality(unsigned int personality);
-
-/* kernel/exit.c */
 asmlinkage long sys_exit(int error_code);
 asmlinkage long sys_exit_group(int error_code);
 asmlinkage long sys_waitid(int which, pid_t pid,
 			   struct siginfo __user *infop,
 			   int options, struct rusage __user *ru);
-
-/* kernel/fork.c */
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_unshare(unsigned long unshare_flags);
-
-/* kernel/futex.c */
 asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
 			struct __kernel_timespec __user *utime, u32 __user *uaddr2,
 			u32 val3);
@@ -585,31 +523,21 @@ asmlinkage long sys_get_robust_list(int pid,
 				    size_t __user *len_ptr);
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
-
-/* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
 				     struct old_timespec32 __user *rmtp);
-
-/* kernel/itimer.c */
 asmlinkage long sys_getitimer(int which, struct __kernel_old_itimerval __user *value);
 asmlinkage long sys_setitimer(int which,
 				struct __kernel_old_itimerval __user *value,
 				struct __kernel_old_itimerval __user *ovalue);
-
-/* kernel/kexec.c */
 asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
 				struct kexec_segment __user *segments,
 				unsigned long flags);
-
-/* kernel/module.c */
 asmlinkage long sys_init_module(void __user *umod, unsigned long len,
 				const char __user *uargs);
 asmlinkage long sys_delete_module(const char __user *name_user,
 				unsigned int flags);
-
-/* kernel/posix-timers.c */
 asmlinkage long sys_timer_create(clockid_t which_clock,
 				 struct sigevent __user *timer_event_spec,
 				 timer_t __user * created_timer_id);
@@ -643,15 +571,9 @@ asmlinkage long sys_clock_getres_time32(clockid_t which_clock,
 asmlinkage long sys_clock_nanosleep_time32(clockid_t which_clock, int flags,
 				struct old_timespec32 __user *rqtp,
 				struct old_timespec32 __user *rmtp);
-
-/* kernel/printk.c */
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
-
-/* kernel/ptrace.c */
 asmlinkage long sys_ptrace(long request, long pid, unsigned long addr,
 			   unsigned long data);
-/* kernel/sched/core.c */
-
 asmlinkage long sys_sched_setparam(pid_t pid,
 					struct sched_param __user *param);
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
@@ -670,8 +592,6 @@ asmlinkage long sys_sched_rr_get_interval(pid_t pid,
 				struct __kernel_timespec __user *interval);
 asmlinkage long sys_sched_rr_get_interval_time32(pid_t pid,
 						 struct old_timespec32 __user *interval);
-
-/* kernel/signal.c */
 asmlinkage long sys_restart_syscall(void);
 asmlinkage long sys_kill(pid_t pid, int sig);
 asmlinkage long sys_tkill(pid_t pid, int sig);
@@ -697,8 +617,6 @@ asmlinkage long sys_rt_sigtimedwait_time32(const sigset_t __user *uthese,
 				const struct old_timespec32 __user *uts,
 				size_t sigsetsize);
 asmlinkage long sys_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t __user *uinfo);
-
-/* kernel/sys.c */
 asmlinkage long sys_setpriority(int which, int who, int niceval);
 asmlinkage long sys_getpriority(int which, int who);
 asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd,
@@ -732,16 +650,12 @@ asmlinkage long sys_umask(int mask);
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
-
-/* kernel/time.c */
 asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
 asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
-
-/* kernel/timer.c */
 asmlinkage long sys_getpid(void);
 asmlinkage long sys_getppid(void);
 asmlinkage long sys_getuid(void);
@@ -750,8 +664,6 @@ asmlinkage long sys_getgid(void);
 asmlinkage long sys_getegid(void);
 asmlinkage long sys_gettid(void);
 asmlinkage long sys_sysinfo(struct sysinfo __user *info);
-
-/* ipc/mqueue.c */
 asmlinkage long sys_mq_open(const char __user *name, int oflag, umode_t mode, struct mq_attr __user *attr);
 asmlinkage long sys_mq_unlink(const char __user *name);
 asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct __kernel_timespec __user *abs_timeout);
@@ -766,8 +678,6 @@ asmlinkage long sys_mq_timedsend_time32(mqd_t mqdes,
 			const char __user *u_msg_ptr,
 			unsigned int msg_len, unsigned int msg_prio,
 			const struct old_timespec32 __user *u_abs_timeout);
-
-/* ipc/msg.c */
 asmlinkage long sys_msgget(key_t key, int msgflg);
 asmlinkage long sys_old_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 asmlinkage long sys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
@@ -775,8 +685,6 @@ asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp,
 				size_t msgsz, long msgtyp, int msgflg);
 asmlinkage long sys_msgsnd(int msqid, struct msgbuf __user *msgp,
 				size_t msgsz, int msgflg);
-
-/* ipc/sem.c */
 asmlinkage long sys_semget(key_t key, int nsems, int semflg);
 asmlinkage long sys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 asmlinkage long sys_old_semctl(int semid, int semnum, int cmd, unsigned long arg);
@@ -788,15 +696,11 @@ asmlinkage long sys_semtimedop_time32(int semid, struct sembuf __user *sops,
 				const struct old_timespec32 __user *timeout);
 asmlinkage long sys_semop(int semid, struct sembuf __user *sops,
 				unsigned nsops);
-
-/* ipc/shm.c */
 asmlinkage long sys_shmget(key_t key, size_t size, int flag);
 asmlinkage long sys_old_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 asmlinkage long sys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg);
 asmlinkage long sys_shmdt(char __user *shmaddr);
-
-/* net/socket.c */
 asmlinkage long sys_socket(int, int, int);
 asmlinkage long sys_socketpair(int, int, int, int __user *);
 asmlinkage long sys_bind(int, struct sockaddr __user *, int);
@@ -816,18 +720,12 @@ asmlinkage long sys_getsockopt(int fd, int level, int optname,
 asmlinkage long sys_shutdown(int, int);
 asmlinkage long sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned flags);
 asmlinkage long sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned flags);
-
-/* mm/filemap.c */
 asmlinkage long sys_readahead(int fd, loff_t offset, size_t count);
-
-/* mm/nommu.c, also with MMU */
 asmlinkage long sys_brk(unsigned long brk);
 asmlinkage long sys_munmap(unsigned long addr, size_t len);
 asmlinkage long sys_mremap(unsigned long addr,
 			   unsigned long old_len, unsigned long new_len,
 			   unsigned long flags, unsigned long new_addr);
-
-/* security/keys/keyctl.c */
 asmlinkage long sys_add_key(const char __user *_type,
 			    const char __user *_description,
 			    const void __user *_payload,
@@ -840,7 +738,6 @@ asmlinkage long sys_request_key(const char __user *_type,
 asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5);
 
-/* arch/example/kernel/sys_example.c */
 #ifdef CONFIG_CLONE_BACKWARDS
 asmlinkage long sys_clone(unsigned long, unsigned long, int __user *, unsigned long,
 	       int __user *);
@@ -859,11 +756,9 @@ asmlinkage long sys_clone3(struct clone_args __user *uargs, size_t size);
 asmlinkage long sys_execve(const char __user *filename,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp);
-
-/* mm/fadvise.c */
 asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
 
-/* mm/, CONFIG_MMU only */
+/* CONFIG_MMU only */
 asmlinkage long sys_swapon(const char __user *specialfile, int swap_flags);
 asmlinkage long sys_swapoff(const char __user *specialfile);
 asmlinkage long sys_mprotect(unsigned long start, size_t len,
@@ -1008,7 +903,6 @@ asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
  * Architecture-specific system calls
  */
 
-/* arch/x86/kernel/ioport.c */
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
@@ -1118,11 +1012,11 @@ asmlinkage long sys_sysfs(int option,
 				unsigned long arg1, unsigned long arg2);
 asmlinkage long sys_fork(void);
 
-/* obsolete: kernel/time/time.c */
+/* obsolete */
 asmlinkage long sys_stime(__kernel_old_time_t __user *tptr);
 asmlinkage long sys_stime32(old_time32_t __user *tptr);
 
-/* obsolete: kernel/signal.c */
+/* obsolete */
 asmlinkage long sys_sigpending(old_sigset_t __user *uset);
 asmlinkage long sys_sigprocmask(int how, old_sigset_t __user *set,
 				old_sigset_t __user *oset);
@@ -1142,19 +1036,19 @@ asmlinkage long sys_sgetmask(void);
 asmlinkage long sys_ssetmask(int newmask);
 asmlinkage long sys_signal(int sig, __sighandler_t handler);
 
-/* obsolete: kernel/sched/core.c */
+/* obsolete */
 asmlinkage long sys_nice(int increment);
 
-/* obsolete: kernel/kexec_file.c */
+/* obsolete */
 asmlinkage long sys_kexec_file_load(int kernel_fd, int initrd_fd,
 				    unsigned long cmdline_len,
 				    const char __user *cmdline_ptr,
 				    unsigned long flags);
 
-/* obsolete: kernel/exit.c */
+/* obsolete */
 asmlinkage long sys_waitpid(pid_t pid, int __user *stat_addr, int options);
 
-/* obsolete: kernel/uid16.c */
+/* obsolete */
 #ifdef CONFIG_HAVE_UID16
 asmlinkage long sys_chown16(const char __user *filename,
 				old_uid_t user, old_gid_t group);
@@ -1181,10 +1075,10 @@ asmlinkage long sys_getgid16(void);
 asmlinkage long sys_getegid16(void);
 #endif
 
-/* obsolete: net/socket.c */
+/* obsolete */
 asmlinkage long sys_socketcall(int call, unsigned long __user *args);
 
-/* obsolete: fs/stat.c */
+/* obsolete */
 asmlinkage long sys_stat(const char __user *filename,
 			struct __old_kernel_stat __user *statbuf);
 asmlinkage long sys_lstat(const char __user *filename,
@@ -1194,13 +1088,13 @@ asmlinkage long sys_fstat(unsigned int fd,
 asmlinkage long sys_readlink(const char __user *path,
 				char __user *buf, int bufsiz);
 
-/* obsolete: fs/select.c */
+/* obsolete */
 asmlinkage long sys_old_select(struct sel_arg_struct __user *arg);
 
-/* obsolete: fs/readdir.c */
+/* obsolete */
 asmlinkage long sys_old_readdir(unsigned int, struct old_linux_dirent __user *, unsigned int);
 
-/* obsolete: kernel/sys.c */
+/* obsolete */
 asmlinkage long sys_gethostname(char __user *name, int len);
 asmlinkage long sys_uname(struct old_utsname __user *);
 asmlinkage long sys_olduname(struct oldold_utsname __user *);
@@ -1208,11 +1102,11 @@ asmlinkage long sys_olduname(struct oldold_utsname __user *);
 asmlinkage long sys_old_getrlimit(unsigned int resource, struct rlimit __user *rlim);
 #endif
 
-/* obsolete: ipc */
+/* obsolete */
 asmlinkage long sys_ipc(unsigned int call, int first, unsigned long second,
 		unsigned long third, void __user *ptr, long fifth);
 
-/* obsolete: mm/ */
+/* obsolete */
 asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			unsigned long fd, unsigned long pgoff);
-- 
2.17.1

