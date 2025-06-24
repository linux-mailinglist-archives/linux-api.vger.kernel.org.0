Return-Path: <linux-api+bounces-3982-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623DCAE6E55
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F677AE5E4
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E942F19B7;
	Tue, 24 Jun 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRxFYgDL"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AE2F0C77;
	Tue, 24 Jun 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788478; cv=none; b=vB1ZZGVecqTLX5m3W/PPpcPU9vCAQjzo0aVkfFpUaHnoMlvnfUAwQ0FQZQPYqc6AJfH/tvjKoN/svmezVRcjXbHrXWjlSSJhLgbdKKX2xAmWqr1gWX2Z4GPZSmbfUl/3enXyZz6u4yZV+R3wmVaFHkSZHkz/RddxF9f6PVeB1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788478; c=relaxed/simple;
	bh=i8/5GgeHil/TNEzb6lJNOuCu39GC+PerV5c31sqY8Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gsn44gBOaxHEuD8NcEAguVjawQEuUFgNhp0XQcVm89NfnGZc+4bQgq9Dc6woFZI3LCd2BkFJpkQWFCkbDHmUAzqRc9pJvadsC5s0pA/uoz9xU+tgepizj7aCyQuHrduV//NhCZ6KJwYE1pN+J81PuiA26zMp5qrnrD/LA4HTi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRxFYgDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BEEC4CEF2;
	Tue, 24 Jun 2025 18:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788478;
	bh=i8/5GgeHil/TNEzb6lJNOuCu39GC+PerV5c31sqY8Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRxFYgDLMwwFmSW65fSyMffHQ/mSpD8PGolAea/Gg4Qbpe6MP+rqZLOTbiydr3Iya
	 SBsic+UmzVPFyV7itHDqaGTaGwDQS0pk92UDHhBXjHzV9oPmIwf1UJLa1AoDDeYuV5
	 i9nfUL9Wrt01OqtK33nfhIlhFN91EkUV/NUSQu18mm++MBWex3ndr8e1bHVluNb8Ur
	 4+ajE3AmZxo8DpWL8dNS3ysr5JsjpZQ3yFGTHf7T0bOHyWAawewF9ZZpqoBQ1ql9CF
	 CIDT4505tykB2mPOl+lwoMfrYmjIG/6Nn7P0oxnJ0UuTYFgl5HYE0NIZgxCVF9siNH
	 xi5CxNTP2XuwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 21/22] net/socket: add API specification for socket()
Date: Tue, 24 Jun 2025 14:07:41 -0400
Message-Id: <20250624180742.5795-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624180742.5795-1-sashal@kernel.org>
References: <20250624180742.5795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel API specification for the socket() system call, documenting
all aspects of socket creation.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/socket.c | 489 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 489 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 9a0e720f08598..fa42497d72af2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -78,6 +78,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/syscall_api_spec.h>
 #include <linux/compat.h>
 #include <linux/kmod.h>
 #include <linux/audit.h>
@@ -89,6 +90,7 @@
 #include <linux/nospec.h>
 #include <linux/indirect_call_wrapper.h>
 #include <linux/io_uring/net.h>
+#include <linux/un.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -1692,6 +1694,493 @@ int __sys_socket(int family, int type, int protocol)
 	return sock_map_fd(sock, flags & (O_CLOEXEC | O_NONBLOCK));
 }
 
+DEFINE_KERNEL_API_SPEC(sys_socket)
+	KAPI_DESCRIPTION("Create an endpoint for communication")
+	KAPI_LONG_DESC("Creates an endpoint for communication and returns a file descriptor "
+		       "that refers to that endpoint. The file descriptor returned by a successful "
+		       "call will be the lowest-numbered file descriptor not currently open for "
+		       "the process. The socket has the indicated type, which specifies the "
+		       "communication semantics. The socket() system call is the foundation of "
+		       "all network programming in Linux, providing access to various network "
+		       "protocols and communication mechanisms.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	KAPI_PARAM(0, "family", "int", "Protocol/address family (domain)")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, 45)  /* AF_UNSPEC to AF_MCTP */
+		KAPI_PARAM_CONSTRAINT("Common families: AF_UNIX (1), AF_INET (2), AF_INET6 (10), "
+				      "AF_NETLINK (16), AF_PACKET (17). Others: AF_BLUETOOTH (31), AF_CAN (29), "
+				      "AF_TIPC (30), AF_VSOCK (40), AF_XDP (44). Range: 0-45 (AF_MCTP). "
+				      "PF_* are aliases. Negative or >= 46 returns EAFNOSUPPORT.")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "type", "int", "Socket type with optional flags")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_MASK)
+		KAPI_PARAM_VALID_MASK(SOCK_TYPE_MASK | SOCK_CLOEXEC | SOCK_NONBLOCK)
+		KAPI_PARAM_CONSTRAINT("Types: SOCK_STREAM (1), SOCK_DGRAM (2), SOCK_RAW (3), "
+				      "SOCK_RDM (4), SOCK_SEQPACKET (5), SOCK_DCCP (6), SOCK_PACKET (10-obsolete). "
+				      "Flags (since 2.6.27): SOCK_NONBLOCK, SOCK_CLOEXEC. Range: 0-10.")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "protocol", "int", "Protocol within the family")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("Usually 0 to select the default protocol for the given family and type. "
+				      "For AF_INET/AF_INET6: IPPROTO_TCP (6), IPPROTO_UDP (17), IPPROTO_ICMP (1), "
+				      "IPPROTO_RAW (255), etc. Must be >= 0 and < IPPROTO_MAX. "
+				      "For AF_UNIX: only 0 or PF_UNIX (1) accepted. "
+				      "For AF_PACKET: network byte order Ethernet protocol (e.g., ETH_P_IP). "
+				      "For AF_NETLINK: NETLINK_ROUTE, NETLINK_AUDIT, etc. (0-31). "
+				      "Protocol value passed through update_socket_protocol() BPF hook which may modify it.")
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "File descriptor on success; negative error code on failure. "
+		    "On success, returns the lowest available file descriptor. "
+		    "The descriptor is automatically placed in the process's file descriptor table. "
+		    "If SOCK_CLOEXEC is set, FD_CLOEXEC is set on the descriptor. "
+		    "If SOCK_NONBLOCK is set, O_NONBLOCK is set on the file.")
+		KAPI_RETURN_TYPE(KAPI_TYPE_FD)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_SUCCESS(0)
+	KAPI_RETURN_END
+
+	/* Core error codes from __sock_create() and __sys_socket() */
+	KAPI_ERROR(0, -EAFNOSUPPORT, "EAFNOSUPPORT", "Address family not supported",
+		   "The implementation does not support the specified address family. "
+		   "Returned when: family < 0 || family >= NPROTO (46); "
+		   "protocol family not registered in net_families[]; "
+		   "protocol family module cannot be loaded; "
+		   "try_module_get() fails on protocol family owner.")
+	KAPI_ERROR(1, -EINVAL, "EINVAL", "Invalid argument",
+		   "Invalid argument specified. Returned when: "
+		   "type < 0 || type >= SOCK_MAX (11); "
+		   "invalid flags in type ((type & ~SOCK_TYPE_MASK) & ~(SOCK_CLOEXEC | SOCK_NONBLOCK)); "
+		   "other protocol-specific validation failures.")
+	KAPI_ERROR(2, -ENFILE, "ENFILE", "File table overflow",
+		   "The system-wide limit on the total number of open files has been reached. "
+		   "Returned when sock_alloc() fails due to new_inode_pseudo() failure.")
+	KAPI_ERROR(3, -EMFILE, "EMFILE", "Too many open files",
+		   "The per-process limit on the number of open file descriptors has been reached. "
+		   "Returned when sock_map_fd() cannot allocate a new file descriptor.")
+	KAPI_ERROR(4, -ENOMEM, "ENOMEM", "Out of memory",
+		   "Insufficient kernel memory available. Can occur in: "
+		   "sk_alloc() when allocating sock structure; "
+		   "protocol-specific init functions; "
+		   "security_sk_alloc() in LSM hooks; "
+		   "various kmalloc()/kmem_cache_alloc() calls.")
+	KAPI_ERROR(5, -ENOBUFS, "ENOBUFS", "No buffer space available",
+		   "Insufficient resources to create socket. Similar to ENOMEM but used by "
+		   "some protocol families (e.g., AF_PACKET) to indicate resource exhaustion.")
+	KAPI_ERROR(6, -EPROTONOSUPPORT, "EPROTONOSUPPORT", "Protocol not supported",
+		   "The protocol is not supported within this domain. Returned when: "
+		   "AF_UNIX: protocol != 0 && protocol != PF_UNIX; "
+		   "AF_INET/AF_INET6: protocol not found in inetsw[] array; "
+		   "AF_NETLINK: protocol < 0 || protocol >= MAX_LINKS (32).")
+	KAPI_ERROR(7, -ESOCKTNOSUPPORT, "ESOCKTNOSUPPORT", "Socket type not supported",
+		   "The socket type is not supported within this domain. Returned when: "
+		   "AF_UNIX: type not in {STREAM, DGRAM, SEQPACKET, RAW}; "
+		   "AF_INET/AF_INET6: no matching (type, protocol) in inetsw[]; "
+		   "AF_PACKET: type not in {DGRAM, RAW, PACKET}; "
+		   "AF_NETLINK: type not in {RAW, DGRAM}.")
+	KAPI_ERROR(8, -EPERM, "EPERM", "Operation not permitted",
+		   "Permission denied due to insufficient privileges. Returned when: "
+		   "AF_INET/AF_INET6 with SOCK_RAW: missing CAP_NET_RAW; "
+		   "AF_PACKET: missing CAP_NET_RAW; "
+		   "Some protocol families may have additional restrictions.")
+	KAPI_ERROR(9, -EACCES, "EACCES", "Permission denied",
+		   "Permission denied by Linux Security Module (SELinux, AppArmor, etc.). "
+		   "Returned by security_socket_create() or security_socket_post_create() hooks.")
+	KAPI_ERROR(10, -EAGAIN, "EAGAIN", "Resource temporarily unavailable",
+		   "Transient resource shortage. Can be returned by some protocol families "
+		   "during initialization when resources are temporarily exhausted.")
+	KAPI_ERROR(11, -EINTR, "EINTR", "Interrupted system call",
+		   "Operation interrupted by signal. Rare for socket() but possible if "
+		   "module loading is interrupted or during memory allocation with GFP_KERNEL.")
+	KAPI_ERROR(12, -EFAULT, "EFAULT", "Bad address",
+		   "Not directly returned by socket() since all parameters are values, not pointers. "
+		   "Listed for completeness as it appears in documentation.")
+	KAPI_ERROR(13, -ENOSYS, "ENOSYS", "Function not implemented",
+		   "Can occur in containers using alt-syscall where socket() is not whitelisted, "
+		   "or on architectures where socket() is not implemented.")
+
+	KAPI_ERROR_COUNT(14)
+	KAPI_PARAM_COUNT(3)
+	KAPI_SINCE_VERSION("4.2BSD")
+
+	KAPI_EXAMPLES("/* Create a TCP socket */\n"
+		      "int tcp_sock = socket(AF_INET, SOCK_STREAM, 0);\n"
+		      "if (tcp_sock < 0) {\n"
+		      "    perror(\"socket\");\n"
+		      "    exit(EXIT_FAILURE);\n"
+		      "}\n\n"
+		      "/* Create a non-blocking UDP socket with close-on-exec */\n"
+		      "int udp_sock = socket(AF_INET6, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);\n\n"
+		      "/* Create a raw ICMP socket (requires CAP_NET_RAW) */\n"
+		      "int raw_sock = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);\n\n"
+		      "/* Create a Unix domain datagram socket */\n"
+		      "int unix_sock = socket(AF_UNIX, SOCK_DGRAM, 0);\n\n"
+		      "/* Create a netlink socket for routing information */\n"
+		      "int nl_sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);\n\n"
+		      "/* Create a packet socket for raw Ethernet frames (requires CAP_NET_RAW) */\n"
+		      "int packet_sock = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));\n\n"
+		      "/* Create a Bluetooth L2CAP socket */\n"
+		      "int bt_sock = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);")
+
+	KAPI_NOTES("Implementation details:\n"
+		   "- Uses RCU to safely access net_families[] array\n"
+		   "- May trigger automatic module loading via request_module(\"net-pf-%d\", family)\n"
+		   "- Allocates inode from sock_inode_cache via new_inode_pseudo()\n"
+		   "- Each protocol family registers via sock_register() with unique family number\n"
+		   "- Socket creation involves: sock_alloc() -> pf->create() -> sock_map_fd()\n"
+		   "- The update_socket_protocol() BPF hook can modify the protocol parameter\n"
+		   "- LSM hooks called: security_socket_create() and security_socket_post_create()\n"
+		   "- Creates struct socket (VFS layer) and struct sock (network layer)\n"
+		   "- Socket state initialized to SS_UNCONNECTED\n"
+		   "- File operations set to socket_file_ops\n"
+		   "- The (PF_INET, SOCK_PACKET) combination is deprecated since Linux 2.0\n"
+		   "Build-time checks ensure SOCK_CLOEXEC == O_CLOEXEC and flag consistency")
+
+	/* Lock specifications */
+	KAPI_LOCK(0, "rcu_read_lock", KAPI_LOCK_RCU)
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Protects net_families[] array access during protocol family lookup. "
+			       "Acquired before rcu_dereference(net_families[family]), "
+			       "released after pf->create() call or on error path.")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(1, "pf->owner module refcount", KAPI_LOCK_CUSTOM)
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Prevents protocol family module unload during socket creation. "
+			       "try_module_get(pf->owner) before pf->create(), "
+			       "module_put(pf->owner) after completion.")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(2, "sock->ops->owner module refcount", KAPI_LOCK_CUSTOM)
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_DESC("Prevents socket operations module unload during socket lifetime. "
+			       "try_module_get(sock->ops->owner) after successful creation, "
+			       "released only on sock_release() when socket is closed.")
+	KAPI_LOCK_END
+
+	KAPI_LOCK_COUNT(3)
+
+	/* Signal handling */
+	KAPI_SIGNAL(0, 0, "Module loading", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RESTART)
+		KAPI_SIGNAL_CONDITION("CONFIG_MODULES && request_module() called")
+		KAPI_SIGNAL_DESC("Module loading via request_module() is interruptible. "
+				 "Signal delivery causes -EINTR from modprobe execution.")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+		KAPI_SIGNAL_INTERRUPTIBLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL_COUNT(1)
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_ALLOC_MEMORY | KAPI_EFFECT_RESOURCE_CREATE,
+			 "socket structures",
+			 "Allocates struct socket (VFS), struct sock (network), and protocol-specific data. "
+			 "Memory from: sock_inode_cache, protocol's slab cache, and general kmalloc.")
+		KAPI_EFFECT_CONDITION("Always occurs on successful socket creation")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_RESOURCE_CREATE,
+			 "file descriptor",
+			 "Allocates new file descriptor at lowest available index. "
+			 "Creates struct file with socket_file_ops. Sets up file->private_data = socket.")
+		KAPI_EFFECT_CONDITION("Always occurs on successful socket creation")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_FILESYSTEM,
+			 "protocol module",
+			 "May trigger request_module(\"net-pf-%d\", family) to load protocol module. "
+			 "Executes /sbin/modprobe in userspace context.")
+		KAPI_EFFECT_CONDITION("CONFIG_MODULES=y && !net_families[family] && first attempt")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_MODIFY_STATE,
+			 "LSM and audit",
+			 "Calls security_socket_create() pre-creation and security_socket_post_create() "
+			 "post-creation. May generate audit events. SELinux/AppArmor may deny.")
+		KAPI_EFFECT_CONDITION("CONFIG_SECURITY=y or CONFIG_AUDIT=y")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(4, KAPI_EFFECT_MODIFY_STATE,
+			 "BPF programs",
+			 "update_socket_protocol() hook can modify protocol parameter. "
+			 "BPF_CGROUP_RUN_PROG_INET_SOCK() may run for AF_INET/AF_INET6.")
+		KAPI_EFFECT_CONDITION("BPF programs attached to cgroup or socket hooks")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(5, KAPI_EFFECT_NETWORK | KAPI_EFFECT_HARDWARE,
+			 "network stack",
+			 "Initializes protocol-specific state. May interact with network hardware "
+			 "(e.g., AF_PACKET binds to network interface).")
+		KAPI_EFFECT_CONDITION("Protocol family specific")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(6, KAPI_EFFECT_MODIFY_STATE,
+			 "resource accounting",
+			 "Updates task and memory cgroup accounting. Charges socket memory to owner. "
+			 "Increments global socket counters.")
+		KAPI_EFFECT_CONDITION("CONFIG_MEMCG=y or other accounting enabled")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(7)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "file descriptor table",
+			 "n open descriptors", "n+1 open descriptors",
+			 "New fd allocated at min(available). Updates current->files->fd_array[]")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "socket state machine",
+			 "non-existent", "SS_UNCONNECTED",
+			 "Socket created in unconnected state, ready for bind() or connect()")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "network namespace",
+			 "no socket", "socket registered",
+			 "Socket associated with current->nsproxy->net_ns network namespace")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "memory accounting",
+			 "pre-allocation", "memory charged",
+			 "Socket memory charged to owner's memcg and rlimits")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(4)
+
+	/* Networking-specific specifications */
+
+	/* Socket state specification */
+	KAPI_SOCKET_STATE_REQ(KAPI_SOCK_STATE_UNSPEC)
+	KAPI_SOCKET_STATE_RESULT(KAPI_SOCK_STATE_OPEN)
+	KAPI_SOCKET_STATE_COND("Successful socket creation")
+	KAPI_SOCKET_STATE_PROTOS(KAPI_PROTO_ALL)
+	KAPI_SOCKET_STATE_END
+
+	/* Protocol-specific behaviors - detailed specifications */
+	KAPI_PROTOCOL_BEHAVIOR(0, KAPI_PROTO_TCP,
+		"TCP (Transmission Control Protocol) creates reliable, ordered, connection-oriented "
+		"byte streams. Features: 3-way handshake connection establishment; sequence numbers "
+		"for ordering; acknowledgments and retransmissions for reliability; flow control "
+		"via sliding window; congestion control (Reno/CUBIC/BBR); Nagle algorithm for "
+		"small packet aggregation; keep-alive probes; urgent data via MSG_OOB. "
+		"Socket combines (AF_INET/AF_INET6, SOCK_STREAM, IPPROTO_TCP).")
+		KAPI_PROTOCOL_FLAGS(0, "TCP-specific socket options via SOL_TCP level")
+	KAPI_PROTOCOL_BEHAVIOR_END
+
+	KAPI_PROTOCOL_BEHAVIOR(1, KAPI_PROTO_UDP,
+		"UDP (User Datagram Protocol) creates unreliable, connectionless datagram service. "
+		"Features: no connection establishment; best-effort delivery; message boundaries "
+		"preserved; no flow/congestion control; optional checksums; multicast/broadcast "
+		"capable; lower overhead than TCP. Maximum datagram size 65507 bytes (65535 - "
+		"IP header - UDP header). connect() on UDP socket sets default destination. "
+		"Socket combines (AF_INET/AF_INET6, SOCK_DGRAM, IPPROTO_UDP).")
+		KAPI_PROTOCOL_FLAGS(0, "UDP-specific options like UDP_CORK via SOL_UDP")
+	KAPI_PROTOCOL_BEHAVIOR_END
+
+	KAPI_PROTOCOL_BEHAVIOR(2, KAPI_PROTO_UNIX,
+		"Unix domain sockets provide high-performance local IPC with filesystem-based "
+		"addressing or Linux abstract namespace. Features: reliable delivery; in-order "
+		"semantics for SOCK_STREAM; message boundaries for SOCK_DGRAM/SOCK_SEQPACKET; "
+		"credential passing via SCM_CREDENTIALS; file descriptor passing via SCM_RIGHTS; "
+		"no network overhead; kernel-only data path. SOCK_RAW mapped to SOCK_DGRAM. "
+		"Maximum datagram size 130688 bytes by default (net.core.wmem_max).")
+		KAPI_PROTOCOL_FLAGS(0, "No Unix-specific socket level; uses SOL_SOCKET only")
+	KAPI_PROTOCOL_BEHAVIOR_END
+
+	KAPI_PROTOCOL_BEHAVIOR(3, KAPI_PROTO_RAW,
+		"Raw sockets provide direct access to network layer (IP) or link layer (Ethernet). "
+		"Features: receive/send raw IP packets; implement custom protocols; packet "
+		"sniffing; bypass transport layer. IP header included based on IP_HDRINCL option. "
+		"Protocol field specifies which protocol to receive (IPPROTO_ICMP, etc.) or "
+		"IPPROTO_RAW to send any. Link layer access via AF_PACKET. Requires CAP_NET_RAW "
+		"capability. Used by ping, traceroute, nmap, tcpdump.")
+		KAPI_PROTOCOL_FLAGS(0, "IP_HDRINCL and raw-specific options via SOL_RAW")
+	KAPI_PROTOCOL_BEHAVIOR_END
+
+	KAPI_PROTOCOL_BEHAVIOR(4, KAPI_PROTO_PACKET,
+		"Packet sockets provide direct access to link layer (Layer 2). Features: "
+		"send/receive raw Ethernet frames; implement network protocols in userspace; "
+		"packet capture and injection; access to all packets on interface. SOCK_RAW "
+		"provides full Layer 2 header; SOCK_DGRAM provides cooked packets without "
+		"Layer 2 header. Protocol specifies Ethernet protocol (ETH_P_IP, ETH_P_ALL). "
+		"High-performance variants: PACKET_MMAP, PACKET_FANOUT. Requires CAP_NET_RAW.")
+		KAPI_PROTOCOL_FLAGS(0, "Extensive options via SOL_PACKET level")
+	KAPI_PROTOCOL_BEHAVIOR_END
+
+	KAPI_PROTOCOL_BEHAVIOR(5, KAPI_PROTO_NETLINK,
+		"Netlink sockets provide kernel/user-space communication interface. Features: "
+		"reliable datagram service; multicast groups; message-based; TLV attributes; "
+		"async notifications; used for routing, netfilter, audit, SELinux, etc. "
+		"Protocol specifies subsystem: NETLINK_ROUTE (routing/link), NETLINK_FIREWALL, "
+		"NETLINK_NETFILTER, NETLINK_AUDIT, etc. No special capabilities for most "
+		"protocols except administrative operations.")
+		KAPI_PROTOCOL_FLAGS(0, "Netlink-specific options and attributes")
+	KAPI_PROTOCOL_BEHAVIOR_END
+
+	KAPI_PROTOCOL_BEHAVIOR(6, KAPI_PROTO_SCTP,
+		"SCTP (Stream Control Transmission Protocol) provides reliable, message-oriented "
+		"service with multi-streaming and multi-homing. Features: message boundaries; "
+		"ordered/unordered delivery; multi-streaming prevents head-of-line blocking; "
+		"multi-homing for redundancy; heartbeats; partial reliability extension. "
+		"4-way handshake with cookie mechanism prevents SYN floods. "
+		"Socket combines (AF_INET/AF_INET6, SOCK_STREAM/SOCK_SEQPACKET, IPPROTO_SCTP).")
+		KAPI_PROTOCOL_FLAGS(0, "SCTP-specific options via SOL_SCTP level")
+	KAPI_PROTOCOL_BEHAVIOR_END
+
+	KAPI_PROTOCOL_BEHAVIOR_COUNT(7)
+
+	/* Buffer specification - not applicable for socket creation */
+	KAPI_BUFFER_SPEC(0)
+	KAPI_BUFFER_SIZE(0, 0, 0)
+	KAPI_BUFFER_END
+
+	/* Async specification - socket creation is synchronous */
+	KAPI_ASYNC_SPEC(KAPI_ASYNC_BLOCK, 0)
+	KAPI_ASYNC_END
+
+	/* Network-specific errors are already covered in main error list */
+
+	/* Address families supported - comprehensive list */
+	KAPI_ADDR_FAMILY(0, AF_UNIX, "AF_UNIX/AF_LOCAL", sizeof(struct sockaddr_un), 2, 110)
+		KAPI_ADDR_FORMAT("struct sockaddr_un { sa_family_t sun_family; char sun_path[108]; }")
+		KAPI_ADDR_FEATURES(false, false, false)
+		KAPI_ADDR_SPECIAL("Abstract namespace: sun_path[0] == '\\0'; "
+				  "Autobind: empty sun_path gets random abstract address; "
+				  "Filesystem: normal paths follow filesystem permissions")
+		KAPI_ADDR_PORTS(0, 0)  /* No port concept */
+	KAPI_ADDR_FAMILY_END
+
+	KAPI_ADDR_FAMILY(1, AF_INET, "AF_INET", sizeof(struct sockaddr_in), 16, 16)
+		KAPI_ADDR_FORMAT("struct sockaddr_in { sa_family_t sin_family; __be16 sin_port; "
+				 "struct in_addr sin_addr; char sin_zero[8]; }")
+		KAPI_ADDR_FEATURES(true, true, true)
+		KAPI_ADDR_SPECIAL("INADDR_ANY (0.0.0.0) - wildcard; "
+				  "INADDR_LOOPBACK (127.0.0.1) - loopback; "
+				  "INADDR_BROADCAST (255.255.255.255) - broadcast; "
+				  "224.0.0.0/4 - multicast range")
+		KAPI_ADDR_PORTS(0, 65535)  /* 0 = ephemeral port assignment */
+	KAPI_ADDR_FAMILY_END
+
+	KAPI_ADDR_FAMILY(2, AF_INET6, "AF_INET6", sizeof(struct sockaddr_in6), 28, 28)
+		KAPI_ADDR_FORMAT("struct sockaddr_in6 { sa_family_t sin6_family; __be16 sin6_port; "
+				 "__be32 sin6_flowinfo; struct in6_addr sin6_addr; __u32 sin6_scope_id; }")
+		KAPI_ADDR_FEATURES(true, true, false)  /* No broadcast in IPv6 */
+		KAPI_ADDR_SPECIAL("in6addr_any (::) - wildcard; "
+				  "in6addr_loopback (::1) - loopback; "
+				  "ff00::/8 - multicast range; "
+				  "fe80::/10 - link-local; "
+				  "::ffff:0:0/96 - IPv4-mapped addresses")
+		KAPI_ADDR_PORTS(0, 65535)
+	KAPI_ADDR_FAMILY_END
+
+	KAPI_ADDR_FAMILY(3, AF_NETLINK, "AF_NETLINK", sizeof(struct sockaddr_nl), 12, 12)
+		KAPI_ADDR_FORMAT("struct sockaddr_nl { sa_family_t nl_family; __u16 nl_pad; "
+				 "__u32 nl_pid; __u32 nl_groups; }")
+		KAPI_ADDR_FEATURES(false, true, false)  /* Multicast via nl_groups */
+		KAPI_ADDR_SPECIAL("nl_pid: 0 = kernel; getpid() = this process; "
+				  "nl_groups: bitmask of multicast groups")
+		KAPI_ADDR_PORTS(0, 0)  /* Uses nl_pid instead */
+	KAPI_ADDR_FAMILY_END
+
+	KAPI_ADDR_FAMILY(4, AF_PACKET, "AF_PACKET", sizeof(struct sockaddr_ll), 20, 20)
+		KAPI_ADDR_FORMAT("struct sockaddr_ll { sa_family_t sll_family; __be16 sll_protocol; "
+				 "int sll_ifindex; __u16 sll_hatype; __u8 sll_pkttype; "
+				 "__u8 sll_halen; __u8 sll_addr[8]; }")
+		KAPI_ADDR_FEATURES(true, true, true)  /* Via sll_pkttype */
+		KAPI_ADDR_SPECIAL("sll_ifindex: 0 = any interface; "
+				  "sll_protocol: ETH_P_ALL = all protocols; "
+				  "sll_pkttype: PACKET_HOST/BROADCAST/MULTICAST/OTHERHOST")
+		KAPI_ADDR_PORTS(0, 0)  /* Layer 2, no ports */
+	KAPI_ADDR_FAMILY_END
+
+	KAPI_ADDR_FAMILY(5, AF_BLUETOOTH, "AF_BLUETOOTH", sizeof(struct sockaddr), 14, 258)
+		KAPI_ADDR_FORMAT("Varies by protocol: sockaddr_l2 (L2CAP), sockaddr_rc (RFCOMM), "
+				 "sockaddr_hci (HCI), sockaddr_sco (SCO)")
+		KAPI_ADDR_FEATURES(false, false, false)
+		KAPI_ADDR_SPECIAL("BDADDR_ANY (00:00:00:00:00:00) - any device; "
+				  "BDADDR_LOCAL (00:00:00:ff:ff:ff) - local adapter")
+		KAPI_ADDR_PORTS(1, 30)  /* PSM for L2CAP, channel for RFCOMM */
+	KAPI_ADDR_FAMILY_END
+
+	KAPI_ADDR_FAMILY_COUNT(6)
+
+	/* Security specification - use existing capability mechanism */
+	KAPI_CAPABILITY(0, CAP_NET_RAW, "CAP_NET_RAW", KAPI_CAP_GRANT_PERMISSION)
+		KAPI_CAP_CONDITION("family == AF_PACKET || type == SOCK_RAW")
+		KAPI_CAP_ALLOWS("Raw socket creation and packet injection")
+		KAPI_CAP_WITHOUT("Permission denied (EPERM)")
+	KAPI_CAPABILITY_END
+
+	KAPI_CAPABILITY_COUNT(1)
+
+	/* Operation characteristics */
+	.is_connection_oriented = false,
+	.is_message_oriented = false,
+	.supports_oob_data = false,
+	.supports_peek = false,
+	.supports_select_poll = false,
+	.is_reentrant = true,
+
+	/* Semantic descriptions */
+	KAPI_NET_DATA_TRANSFER("Not applicable - socket() only creates the endpoint")
+
+	/* Additional constraints and validation rules */
+	KAPI_CONSTRAINT(0, "Protocol/Type Compatibility",
+			"Not all (family, type, protocol) combinations are valid. "
+			"Common valid combinations: "
+			"(AF_INET, SOCK_STREAM, IPPROTO_TCP); "
+			"(AF_INET, SOCK_DGRAM, IPPROTO_UDP); "
+			"(AF_INET, SOCK_RAW, IPPROTO_ICMP); "
+			"(AF_UNIX, SOCK_STREAM, 0); "
+			"(AF_UNIX, SOCK_DGRAM, 0); "
+			"(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)); "
+			"(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE)")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(1, "Module Loading",
+			"If protocol family module not loaded, socket() may block during "
+			"request_module() execution. This is interruptible and may take "
+			"significant time. Modules loaded: net-pf-N where N is family number.")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(2, "Capability Requirements",
+			"CAP_NET_RAW required for: "
+			"- AF_INET/AF_INET6 with SOCK_RAW "
+			"- AF_PACKET with any socket type "
+			"- Some AF_NETLINK operations require CAP_NET_ADMIN "
+			"- AF_BLUETOOTH may require CAP_NET_ADMIN for some operations")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(3, "Network Namespace",
+			"Socket is created in current->nsproxy->net_ns network namespace. "
+			"Socket is bound to this namespace for its lifetime. "
+			"Different namespaces have independent network stacks.")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(4, "Memory Limits",
+			"Socket creation respects: "
+			"- RLIMIT_NOFILE for file descriptor limits "
+			"- Memory cgroup limits for socket memory "
+			"- System-wide socket memory limits (net.core.somaxconn, etc.) "
+			"- Per-protocol memory limits")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT_COUNT(5)
+
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE3(socket, int, family, int, type, int, protocol)
 {
 	return __sys_socket(family, type, protocol);
-- 
2.39.5


