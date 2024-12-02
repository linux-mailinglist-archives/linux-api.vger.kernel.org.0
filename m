Return-Path: <linux-api+bounces-2809-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010879DF9B7
	for <lists+linux-api@lfdr.de>; Mon,  2 Dec 2024 04:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28ECCB21194
	for <lists+linux-api@lfdr.de>; Mon,  2 Dec 2024 03:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751F1F8ADA;
	Mon,  2 Dec 2024 03:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y+XzsB8F"
X-Original-To: linux-api@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FA17C2;
	Mon,  2 Dec 2024 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733111842; cv=none; b=b/VeyUKW+7DyZYkf2YknrSfHAWDxuWctC4FNLZd+22XjtX0V1rxTs6BOPwX7iUgmXtfZKYKhl9SR6Mtvx2245jdnf+588CZAHtx8kb1gsncuB9CwilwAKxVOYsWYmsoxy1ZjlJFzADym4JINm/u9txnSiHqyfXYjGMc7Khey2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733111842; c=relaxed/simple;
	bh=6FtZpyVTsYEKvzWFcs/e45vC3Md9HfjC+udZ4ESUCKY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=h/EXlpDcKeiZEtnhyrpbT+BSAhhwhTLpAhx8fJUBGWrANyAc2XO3wRfEAoL0cP9Bv/CRxP+K9Z2GtXd5T9794+cfGVomIKY1H/HpkSmjSUDCivbd9R2v09EE+DbIV4YwTgNSf5ab8ysORGqh2loqlGXYhjiG/lt1K593YQt+6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y+XzsB8F; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733111830; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=QORVjUj1CeiEmSC4CY/0G7wxN4xv6poeDuTgOOMtfh4=;
	b=Y+XzsB8FmkGgUwD59DCqDoVVUmtQrsI4CP58fLD+9M6nKvjQT+4y8CCFPr7CgeadYzHjddyv/6qfnMTklCrFKDYlXE6mhYKnSFHJG2VqbwDVVTBYUBuujvmM1Mwi31cvvzAhGM/I+1A6Xls/MgAMIsL/HHGki9YQ8Ot0QCF0P/o=
Received: from 30.221.145.168(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WKcFYL7_1733111510 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Dec 2024 11:51:51 +0800
Message-ID: <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>
Date: Mon, 2 Dec 2024 11:51:48 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "D. Wythe" <alibuda@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
 linux-api@vger.kernel.org
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <20241111234006.5942-12-ouster@cs.stanford.edu>
Content-Language: en-US
In-Reply-To: <20241111234006.5942-12-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/24 7:40 AM, John Ousterhout wrote:
> homa_plumbing.c contains functions that connect Homa to the rest of
> the Linux kernel, such as dispatch tables used by Linux and the
> top-level functions that Linux invokes from those dispatch tables.
> 
> homa_utils.c contains a few odds and ends, such as code to initialize
> and destroy struct homa's.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>   net/homa/homa_plumbing.c | 965 +++++++++++++++++++++++++++++++++++++++
>   net/homa/homa_utils.c    | 150 ++++++
>   2 files changed, 1115 insertions(+)
>   create mode 100644 net/homa/homa_plumbing.c
>   create mode 100644 net/homa/homa_utils.c
> 
> diff --git a/net/homa/homa_plumbing.c b/net/homa/homa_plumbing.c
> new file mode 100644
> index 000000000000..afd3a9cc97ba
> --- /dev/null
> +++ b/net/homa/homa_plumbing.c
> @@ -0,0 +1,965 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/* This file consists mostly of "glue" that hooks Homa into the rest of
> + * the Linux kernel. The guts of the protocol are in other files.
> + */
> +
> +#include "homa_impl.h"
> +#include "homa_peer.h"
> +#include "homa_pool.h"
> +
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_AUTHOR("John Ousterhout");
> +MODULE_DESCRIPTION("Homa transport protocol");
> +MODULE_VERSION("0.01");
> +
> +/* Not yet sure what these variables are for */
> +static long sysctl_homa_mem[3] __read_mostly;
> +static int sysctl_homa_rmem_min __read_mostly;
> +static int sysctl_homa_wmem_min __read_mostly;
> +
> +/* Global data for Homa. Never reference homa_data directory. Always use
> + * the homa variable instead; this allows overriding during unit tests.
> + */
> +static struct homa homa_data;
> +struct homa *homa = &homa_data;
> +
> +/* True means that the Homa module is in the process of unloading itself,
> + * so everyone should clean up.
> + */
> +static bool exiting;
> +
> +/* Thread that runs timer code to detect lost packets and crashed peers. */
> +static struct task_struct *timer_kthread;
> +
> +/* This structure defines functions that handle various operations on
> + * Homa sockets. These functions are relatively generic: they are called
> + * to implement top-level system calls. Many of these operations can
> + * be implemented by PF_INET6 functions that are independent of the
> + * Homa protocol.
> + */
> +static const struct proto_ops homa_proto_ops = {
> +	.family		   = PF_INET,
> +	.owner		   = THIS_MODULE,
> +	.release	   = inet_release,
> +	.bind		   = homa_bind,
> +	.connect	   = inet_dgram_connect,
> +	.socketpair	   = sock_no_socketpair,
> +	.accept		   = sock_no_accept,
> +	.getname	   = inet_getname,
> +	.poll		   = homa_poll,
> +	.ioctl		   = inet_ioctl,
> +	.listen		   = sock_no_listen,
> +	.shutdown	   = homa_shutdown,
> +	.setsockopt	   = sock_common_setsockopt,
> +	.getsockopt	   = sock_common_getsockopt,
> +	.sendmsg	   = inet_sendmsg,
> +	.recvmsg	   = inet_recvmsg,
> +	.mmap		   = sock_no_mmap,
> +	.set_peek_off	   = sk_set_peek_off,
> +};
> +
> +static const struct proto_ops homav6_proto_ops = {
> +	.family		   = PF_INET6,
> +	.owner		   = THIS_MODULE,
> +	.release	   = inet6_release,
> +	.bind		   = homa_bind,
> +	.connect	   = inet_dgram_connect,
> +	.socketpair	   = sock_no_socketpair,
> +	.accept		   = sock_no_accept,
> +	.getname	   = inet6_getname,
> +	.poll		   = homa_poll,
> +	.ioctl		   = inet6_ioctl,
> +	.listen		   = sock_no_listen,
> +	.shutdown	   = homa_shutdown,
> +	.setsockopt	   = sock_common_setsockopt,
> +	.getsockopt	   = sock_common_getsockopt,
> +	.sendmsg	   = inet_sendmsg,
> +	.recvmsg	   = inet_recvmsg,
> +	.mmap		   = sock_no_mmap,
> +	.set_peek_off	   = sk_set_peek_off,
> +};
> +
> +/* This structure also defines functions that handle various operations
> + * on Homa sockets. However, these functions are lower-level than those
> + * in homa_proto_ops: they are specific to the PF_INET or PF_INET6
> + * protocol family, and in many cases they are invoked by functions in
> + * homa_proto_ops. Most of these functions have Homa-specific implementations.
> + */
> +static struct proto homa_prot = {
> +	.name		   = "HOMA",
> +	.owner		   = THIS_MODULE,
> +	.close		   = homa_close,
> +	.connect	   = ip4_datagram_connect,
> +	.disconnect	   = homa_disconnect,
> +	.ioctl		   = homa_ioctl,
> +	.init		   = homa_socket,
> +	.destroy	   = NULL,
> +	.setsockopt	   = homa_setsockopt,
> +	.getsockopt	   = homa_getsockopt,
> +	.sendmsg	   = homa_sendmsg,
> +	.recvmsg	   = homa_recvmsg,
> +	.backlog_rcv       = homa_backlog_rcv,
> +	.hash		   = homa_hash,
> +	.unhash		   = homa_unhash,
> +	.get_port	   = homa_get_port,
> +	.sysctl_mem	   = sysctl_homa_mem,
> +	.sysctl_wmem	   = &sysctl_homa_wmem_min,
> +	.sysctl_rmem	   = &sysctl_homa_rmem_min,
> +	.obj_size	   = sizeof(struct homa_sock),
> +	.no_autobind       = 1,
> +};
> +
> +static struct proto homav6_prot = {
> +	.name		   = "HOMAv6",
> +	.owner		   = THIS_MODULE,
> +	.close		   = homa_close,
> +	.connect	   = ip6_datagram_connect,
> +	.disconnect	   = homa_disconnect,
> +	.ioctl		   = homa_ioctl,
> +	.init		   = homa_socket,
> +	.destroy	   = NULL,
> +	.setsockopt	   = homa_setsockopt,
> +	.getsockopt	   = homa_getsockopt,
> +	.sendmsg	   = homa_sendmsg,
> +	.recvmsg	   = homa_recvmsg,
> +	.backlog_rcv       = homa_backlog_rcv,
> +	.hash		   = homa_hash,
> +	.unhash		   = homa_unhash,
> +	.get_port	   = homa_get_port,
> +	.sysctl_mem	   = sysctl_homa_mem,
> +	.sysctl_wmem	   = &sysctl_homa_wmem_min,
> +	.sysctl_rmem	   = &sysctl_homa_rmem_min,
> +
> +	/* IPv6 data comes *after* Homa's data, and isn't included in
> +	 * struct homa_sock.
> +	 */
> +	.obj_size	   = sizeof(struct homa_sock) + sizeof(struct ipv6_pinfo),
> +	.no_autobind       = 1,
> +};
> +
> +/* Top-level structure describing the Homa protocol. */
> +static struct inet_protosw homa_protosw = {
> +	.type              = SOCK_DGRAM,
> +	.protocol          = IPPROTO_HOMA,
> +	.prot              = &homa_prot,
> +	.ops               = &homa_proto_ops,
> +	.flags             = INET_PROTOSW_REUSE,
> +};
> +
> +static struct inet_protosw homav6_protosw = {
> +	.type              = SOCK_DGRAM,
> +	.protocol          = IPPROTO_HOMA,
> +	.prot              = &homav6_prot,
> +	.ops               = &homav6_proto_ops,
> +	.flags             = INET_PROTOSW_REUSE,
> +};
> +
> +/* This structure is used by IP to deliver incoming Homa packets to us. */
> +static struct net_protocol homa_protocol = {
> +	.handler =	homa_softirq,
> +	.err_handler =	homa_err_handler_v4,
> +	.no_policy =     1,
> +};
> +
> +static struct inet6_protocol homav6_protocol = {
> +	.handler =	homa_softirq,
> +	.err_handler =	homa_err_handler_v6,
> +	.flags =        INET6_PROTO_NOPOLICY | INET6_PROTO_FINAL,
> +};
> +
> +/* Sizes of the headers for each Homa packet type, in bytes. */
> +static __u16 header_lengths[] = {
> +	sizeof32(struct data_header),
> +	0,
> +	sizeof32(struct resend_header),
> +	sizeof32(struct unknown_header),
> +	sizeof32(struct busy_header),
> +	0,
> +	sizeof32(struct common_header),
> +	sizeof32(struct need_ack_header),
> +	sizeof32(struct ack_header)
> +};
> +
> +static DECLARE_COMPLETION(timer_thread_done);
> +
> +/**
> + * homa_load() - invoked when this module is loaded into the Linux kernel
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +static int __init homa_load(void)
> +{
> +	int status;
> +
> +	pr_notice("Homa module loading\n");
> +	pr_notice("Homa structure sizes: data_header %u, seg_header %u, ack %u, peer %u, ip_hdr %u flowi %u ipv6_hdr %u, flowi6 %u tcp_sock %u homa_rpc %u sk_buff %u rcvmsg_control %u union sockaddr_in_union %u HOMA_MAX_BPAGES %u NR_CPUS %u nr_cpu_ids %u, MAX_NUMNODES %d\n",
> +		  sizeof32(struct data_header),
> +		  sizeof32(struct seg_header),
> +		  sizeof32(struct homa_ack),
> +		  sizeof32(struct homa_peer),
> +		  sizeof32(struct iphdr),
> +		  sizeof32(struct flowi),
> +		  sizeof32(struct ipv6hdr),
> +		  sizeof32(struct flowi6),
> +		  sizeof32(struct tcp_sock),
> +		  sizeof32(struct homa_rpc),
> +		  sizeof32(struct sk_buff),
> +		  sizeof32(struct homa_recvmsg_args),
> +		  sizeof32(union sockaddr_in_union),
> +		  HOMA_MAX_BPAGES,
> +		  NR_CPUS,
> +		  nr_cpu_ids,
> +		  MAX_NUMNODES);
> +	status = proto_register(&homa_prot, 1);
> +	if (status != 0) {
> +		pr_err("proto_register failed for homa_prot: %d\n", status);
> +		goto out;
> +	}
> +	status = proto_register(&homav6_prot, 1);
> +	if (status != 0) {
> +		pr_err("proto_register failed for homav6_prot: %d\n", status);
> +		goto out;
> +	}
> +	inet_register_protosw(&homa_protosw);
> +	inet6_register_protosw(&homav6_protosw);
> +	status = inet_add_protocol(&homa_protocol, IPPROTO_HOMA);
> +	if (status != 0) {
> +		pr_err("inet_add_protocol failed in %s: %d\n", __func__,
> +		       status);
> +		goto out_cleanup;
> +	}
> +	status = inet6_add_protocol(&homav6_protocol, IPPROTO_HOMA);
> +	if (status != 0) {
> +		pr_err("inet6_add_protocol failed in %s: %d\n",  __func__,
> +		       status);
> +		goto out_cleanup;
> +	}
> +
> +	status = homa_init(homa);
> +	if (status)
> +		goto out_cleanup;
> +
> +	timer_kthread = kthread_run(homa_timer_main, homa, "homa_timer");
> +	if (IS_ERR(timer_kthread)) {
> +		status = PTR_ERR(timer_kthread);
> +		pr_err("couldn't create homa pacer thread: error %d\n",
> +		       status);
> +		timer_kthread = NULL;
> +		goto out_cleanup;
> +	}
> +
> +	return 0;
> +
> +out_cleanup:
> +	homa_destroy(homa);
> +	inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
> +	inet_unregister_protosw(&homa_protosw);
> +	inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
> +	inet6_unregister_protosw(&homav6_protosw);
> +	proto_unregister(&homa_prot);
> +	proto_unregister(&homav6_prot);
> +out:
> +	return status;
> +}
> +
> +/**
> + * homa_unload() - invoked when this module is unloaded from the Linux kernel.
> + */
> +static void __exit homa_unload(void)
> +{
> +	pr_notice("Homa module unloading\n");
> +	exiting = true;
> +
> +	if (timer_kthread)
> +		wake_up_process(timer_kthread);
> +	wait_for_completion(&timer_thread_done);
> +	homa_destroy(homa);
> +	inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
> +	inet_unregister_protosw(&homa_protosw);
> +	inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
> +	inet6_unregister_protosw(&homav6_protosw);
> +	proto_unregister(&homa_prot);
> +	proto_unregister(&homav6_prot);
> +}
> +
> +module_init(homa_load);
> +module_exit(homa_unload);
> +
> +/**
> + * homa_bind() - Implements the bind system call for Homa sockets: associates
> + * a well-known service port with a socket. Unlike other AF_INET6 protocols,
> + * there is no need to invoke this system call for sockets that are only
> + * used as clients.
> + * @sock:     Socket on which the system call was invoked.
> + * @addr:    Contains the desired port number.
> + * @addr_len: Number of bytes in uaddr.
> + * Return:    0 on success, otherwise a negative errno.
> + */
> +int homa_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
> +{
> +	struct homa_sock *hsk = homa_sk(sock->sk);
> +	union sockaddr_in_union *addr_in = (union sockaddr_in_union *)addr;
> +	int port = 0;
> +
> +	if (unlikely(addr->sa_family != sock->sk->sk_family))
> +		return -EAFNOSUPPORT;
> +	if (addr_in->in6.sin6_family == AF_INET6) {
> +		if (addr_len < sizeof(struct sockaddr_in6))
> +			return -EINVAL;
> +		port = ntohs(addr_in->in4.sin_port);
> +	} else if (addr_in->in4.sin_family == AF_INET) {
> +		if (addr_len < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		port = ntohs(addr_in->in6.sin6_port);
> +	}
> +	return homa_sock_bind(homa->port_map, hsk, port);
> +}
> +
> +/**
> + * homa_close() - Invoked when close system call is invoked on a Homa socket.
> + * @sk:      Socket being closed
> + * @timeout: ??
> + */
> +void homa_close(struct sock *sk, long timeout)
> +{
> +	struct homa_sock *hsk = homa_sk(sk);
> +
> +	homa_sock_destroy(hsk);
> +	sk_common_release(sk);
> +}
> +
> +/**
> + * homa_shutdown() - Implements the shutdown system call for Homa sockets.
> + * @sock:    Socket to shut down.
> + * @how:     Ignored: for other sockets, can independently shut down
> + *           sending and receiving, but for Homa any shutdown will
> + *           shut down everything.
> + *
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +int homa_shutdown(struct socket *sock, int how)
> +{
> +	homa_sock_shutdown(homa_sk(sock->sk));
> +	return 0;
> +}
> +
> +/**
> + * homa_disconnect() - Invoked when disconnect system call is invoked on a
> + * Homa socket.
> + * @sk:    Socket to disconnect
> + * @flags: ??
> + *
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +int homa_disconnect(struct sock *sk, int flags)
> +{
> +	pr_warn("unimplemented disconnect invoked on Homa socket\n");
> +	return -EINVAL;
> +}
> +
> +/**
> + * homa_ioctl() - Implements the ioctl system call for Homa sockets.
> + * @sk:    Socket on which the system call was invoked.
> + * @cmd:   Identifier for a particular ioctl operation.
> + * @karg:  Operation-specific argument; typically the address of a block
> + *         of data in user address space.
> + *
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +int homa_ioctl(struct sock *sk, int cmd, int *karg)
> +{
> +	return -EINVAL;
> +}
> +
> +/**
> + * homa_socket() - Implements the socket(2) system call for sockets.
> + * @sk:    Socket on which the system call was invoked. The non-Homa
> + *         parts have already been initialized.
> + *
> + * Return: always 0 (success).
> + */
> +int homa_socket(struct sock *sk)
> +{
> +	struct homa_sock *hsk = homa_sk(sk);
> +
> +	homa_sock_init(hsk, homa);
> +	return 0;
> +}
> +
> +/**
> + * homa_setsockopt() - Implements the getsockopt system call for Homa sockets.
> + * @sk:      Socket on which the system call was invoked.
> + * @level:   Level at which the operation should be handled; will always
> + *           be IPPROTO_HOMA.
> + * @optname: Identifies a particular setsockopt operation.
> + * @optval:  Address in user space of information about the option.
> + * @optlen:  Number of bytes of data at @optval.
> + * Return:   0 on success, otherwise a negative errno.
> + */
> +int homa_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
> +		    unsigned int optlen)
> +{
> +	struct homa_sock *hsk = homa_sk(sk);
> +	struct homa_set_buf_args args;
> +	int ret;
> +
> +	if (level != IPPROTO_HOMA || optname != SO_HOMA_SET_BUF ||
> +	    optlen != sizeof(struct homa_set_buf_args))
> +		return -EINVAL;

SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also can be
implemented in getsockopt.

> +
> +	if (copy_from_sockptr(&args, optval, optlen))
> +		return -EFAULT;
> +
> +	/* Do a trivial test to make sure we can at least write the first
> +	 * page of the region.
> +	 */
> +	if (copy_to_user((__force void __user *)args.start, &args, sizeof(args)))
> +		return -EFAULT;

To share buffer between kernel and userspace, maybe you should refer to the implementation of 
io_pin_pbuf_ring()


> +
> +	homa_sock_lock(hsk, "homa_setsockopt SO_HOMA_SET_BUF");
> +	ret = homa_pool_init(hsk, (__force void __user *)args.start, args.length);
> +	homa_sock_unlock(hsk);

It seems that if the option was not set, poll->hsk will not be initialized
and then if recvmsg is called, a panic will be triggered.

homa_recvmsg
homa_wait_for_message
...
homa_rpc_reap
homa_pool_check_waiting
homa_sock_lock(pool->hsk, "buffer pool");


> +	return ret;
> +}
> +
> +/**
> + * homa_getsockopt() - Implements the getsockopt system call for Homa sockets.
> + * @sk:      Socket on which the system call was invoked.
> + * @level:   ??
> + * @optname: Identifies a particular setsockopt operation.
> + * @optval:  Address in user space where the option's value should be stored.
> + * @option:  ??.
> + * Return:   0 on success, otherwise a negative errno.
> + */
> +int homa_getsockopt(struct sock *sk, int level, int optname,
> +		    char __user *optval, int __user *option)
> +{
> +	pr_warn("unimplemented getsockopt invoked on Homa socket: level %d, optname %d\n",
> +		level, optname);
> +	return -EINVAL;
> +}
> +
> +/**
> + * homa_sendmsg() - Send a request or response message on a Homa socket.
> + * @sk:     Socket on which the system call was invoked.
> + * @msg:    Structure describing the message to send; the msg_control
> + *          field points to additional information.
> + * @length: Number of bytes of the message.
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +int homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t length)
> +{
> +	struct homa_sock *hsk = homa_sk(sk);
> +	struct homa_sendmsg_args args;
> +	int result = 0;
> +	struct homa_rpc *rpc = NULL;
> +	union sockaddr_in_union *addr = (union sockaddr_in_union *)msg->msg_name;

msg->msg_name can be NULL.

> +
> +	if (unlikely(!msg->msg_control_is_user)) {
> +		result = -EINVAL;
> +		goto error;
> +	}
> +	if (unlikely(copy_from_user(&args,
> +				    (__force void __user *)msg->msg_control,
> +				    sizeof(args)))) {
> +		result = -EFAULT;
> +		goto error;
> +	}
> +	if (addr->in6.sin6_family != sk->sk_family) {
> +		result = -EAFNOSUPPORT;
> +		goto error;
> +	}

addr->sa.sa_family? Using sin6_family would be odd to me, making it seem like homa can only run with 
IPv6.


> +	if (msg->msg_namelen < sizeof(struct sockaddr_in) ||
> +	    (msg->msg_namelen < sizeof(struct sockaddr_in6) &&
> +	     addr->in6.sin6_family == AF_INET6)) {
> +		result = -EINVAL;
> +		goto error;
> +	}
> +
> +	if (!args.id) {
> +		/* This is a request message. */
> +		rpc = homa_rpc_new_client(hsk, addr);
> +		if (IS_ERR(rpc)) {
> +			result = PTR_ERR(rpc);
> +			rpc = NULL;
> +			goto error;
> +		}
> +		rpc->completion_cookie = args.completion_cookie;
> +		result = homa_message_out_fill(rpc, &msg->msg_iter, 1);
> +		if (result)
> +			goto error;
> +		args.id = rpc->id;
> +		homa_rpc_unlock(rpc);

Strongly recommend that adding comments with all the unlock part to indicate where it was
locked from.


> +		rpc = NULL;
> +
> +		if (unlikely(copy_to_user((__force void __user *)msg->msg_control,
> +					  &args, sizeof(args)))) {
> +			rpc = homa_find_client_rpc(hsk, args.id);
> +			result = -EFAULT;
> +			goto error;
> +		}
> +	} else {
> +		/* This is a response message. */
> +		struct in6_addr canonical_dest;
> +
> +		if (args.completion_cookie != 0) {
> +			result = -EINVAL;
> +			goto error;
> +		}
> +		canonical_dest = canonical_ipv6_addr(addr);

Are you treating all addresses as IPv6 addresses just for the sake of simplicity? It's a bit odd, 
but okay to me.

> +
> +		rpc = homa_find_server_rpc(hsk, &canonical_dest,
> +					   ntohs(addr->in6.sin6_port), args.id);
> +		if (!rpc)
> +			/* Return without an error if the RPC doesn't exist;
> +			 * this could be totally valid (e.g. client is
> +			 * no longer interested in it).
> +			 */
> +			return 0;
> +		if (rpc->error) {
> +			result = rpc->error;
> +			goto error;
> +		}
> +		if (rpc->state != RPC_IN_SERVICE) {
> +			homa_rpc_unlock(rpc);
> +			rpc = NULL;
> +			result = -EINVAL;
> +			goto error;
> +		}
> +		rpc->state = RPC_OUTGOING;
> +
> +		result = homa_message_out_fill(rpc, &msg->msg_iter, 1);
> +		if (result && rpc->state != RPC_DEAD)
> +			goto error;
> +		homa_rpc_unlock(rpc);
> +	}
> +	return 0;
> +
> +error:
> +	if (rpc) {
> +		homa_rpc_free(rpc);
> +		homa_rpc_unlock(rpc);
> +	}
> +	return result;
> +}
> +
> +/**
> + * homa_recvmsg() - Receive a message from a Homa socket.
> + * @sk:          Socket on which the system call was invoked.
> + * @msg:         Controlling information for the receive.
> + * @len:         Total bytes of space available in msg->msg_iov; not used.
> + * @flags:       Flags from system call; only MSG_DONTWAIT is used.
> + * @addr_len:    Store the length of the sender address here
> + * Return:       The length of the message on success, otherwise a negative
> + *               errno.
> + */
> +int homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
> +		 int *addr_len)
> +{
> +	struct homa_sock *hsk = homa_sk(sk);
> +	struct homa_recvmsg_args control;
> +	struct homa_rpc *rpc;
> +	int result;
> +
> +	if (unlikely(!msg->msg_control)) {
> +		/* This test isn't strictly necessary, but it provides a
> +		 * hook for testing kernel call times.
> +		 */
> +		return -EINVAL;
> +	}
> +	if (msg->msg_controllen != sizeof(control)) {
> +		result = -EINVAL;
> +		goto done;

Then you copied an uninitialized control into userspace ...
Is goto really necessary ? Maybe just return.

> +	}
> +	if (unlikely(copy_from_user(&control,
> +				    (__force void __user *)msg->msg_control,
> +				    sizeof(control)))) {
> +		result = -EFAULT;
> +		goto done;

Same as above, is goto really necessary ?

> +	}
> +	control.completion_cookie = 0;
> +
> +	if (control.num_bpages > HOMA_MAX_BPAGES ||
> +	    (control.flags & ~HOMA_RECVMSG_VALID_FLAGS)) {
> +		result = -EINVAL;
> +		goto done;
> +	}
> +	homa_pool_release_buffers(hsk->buffer_pool, control.num_bpages,
> +				  control.bpage_offsets);

homa_pool_release_buffers() quietly ignores erroneous bpage_index values passed in from the 
userspace. This behavior may obscure more complex issues in userspace, and exposure this problem 
could help users identify issues earlier.


> +	control.num_bpages = 0;
> +
> +	rpc = homa_wait_for_message(hsk, (flags & MSG_DONTWAIT)
> +			? (control.flags | HOMA_RECVMSG_NONBLOCKING)
> +			: control.flags, control.id);
> +	if (IS_ERR(rpc)) {
> +		/* If we get here, it means there was an error that prevented
> +		 * us from finding an RPC to return. If there's an error in
> +		 * the RPC itself we won't get here.
> +		 */
> +		result = PTR_ERR(rpc);
> +		goto done;
> +	}
> +	result = rpc->error ? rpc->error : rpc->msgin.length;

A trivial tips.

result = rpc->error ?: rpc->msgin.length;

> +
> +	/* Collect result information. */
> +	control.id = rpc->id;
> +	control.completion_cookie = rpc->completion_cookie;
> +	if (likely(rpc->msgin.length >= 0)) {
> +		control.num_bpages = rpc->msgin.num_bpages;
> +		memcpy(control.bpage_offsets, rpc->msgin.bpage_offsets,
> +		       sizeof(control.bpage_offsets));

A trivial tips.

Although sizeof(control.bpage_offsets) and sizeof(rpc->msgin.bpage_offsets) are the same, but 
passing sizeof(rpc->msgin.bpage_offsets) would be more appropriate.


> +	}
> +	if (sk->sk_family == AF_INET6) {
> +		struct sockaddr_in6 *in6 = msg->msg_name;
> +
> +		in6->sin6_family = AF_INET6;
> +		in6->sin6_port = htons(rpc->dport);
> +		in6->sin6_addr = rpc->peer->addr;
> +		*addr_len = sizeof(*in6);
> +	} else {
> +		struct sockaddr_in *in4 = msg->msg_name;
> +
> +		in4->sin_family = AF_INET;
> +		in4->sin_port = htons(rpc->dport);
> +		in4->sin_addr.s_addr = ipv6_to_ipv4(rpc->peer->addr);
> +		*addr_len = sizeof(*in4);
> +	}
> +
> +	/* This indicates that the application now owns the buffers, so
> +	 * we won't free them in homa_rpc_free.
> +	 */
> +	rpc->msgin.num_bpages = 0;
> +
> +	/* Must release the RPC lock (and potentially free the RPC) before
> +	 * copying the results back to user space.
> +	 */
> +	if (homa_is_client(rpc->id)) {
> +		homa_peer_add_ack(rpc);
> +		homa_rpc_free(rpc);
> +	} else {
> +		if (result < 0)
> +			homa_rpc_free(rpc);
> +		else
> +			rpc->state = RPC_IN_SERVICE;
> +	}
> +	homa_rpc_unlock(rpc);
> +
> +done:
> +	if (unlikely(copy_to_user((__force void __user *)msg->msg_control,
> +		     &control, sizeof(control)))) {
> +		/* Note: in this case the message's buffers will be leaked. */
> +		pr_notice("%s couldn't copy back args\n", __func__); > +		result = -EFAULT;
> +	}
> +
> +	return result;
> +}
> +
> +/**
> + * homa_hash() - Not needed for Homa.
> + * @sk:    Socket for the operation
> + * Return: ??
> + */
> +int homa_hash(struct sock *sk)
> +{
> +	return 0;
> +}
> +
> +/**
> + * homa_unhash() - Not needed for Homa.
> + * @sk:    Socket for the operation
> + */
> +void homa_unhash(struct sock *sk)
> +{
> +}
> +
> +/**
> + * homa_get_port() - It appears that this function is called to assign a
> + * default port for a socket.
> + * @sk:    Socket for the operation
> + * @snum:  Unclear what this is.
> + * Return: Zero for success, or a negative errno for an error.
> + */
> +int homa_get_port(struct sock *sk, unsigned short snum)
> +{
> +	/* Homa always assigns ports immediately when a socket is created,
> +	 * so there is nothing to do here.
> +	 */
> +	return 0;
> +}
> +
> +/**
> + * homa_softirq() - This function is invoked at SoftIRQ level to handle
> + * incoming packets.
> + * @skb:   The incoming packet.
> + * Return: Always 0
> + */
> +int homa_softirq(struct sk_buff *skb)
> +{
> +	struct sk_buff *packets, *other_pkts, *next;
> +	struct sk_buff **prev_link, **other_link;
> +	struct common_header *h;
> +	int first_packet = 1;
> +	int header_offset;
> +	int pull_length;
> +
> +	/* skb may actually contain many distinct packets, linked through
> +	 * skb_shinfo(skb)->frag_list by the Homa GRO mechanism. Make a
> +	 * pass through the list to process all of the short packets,
> +	 * leaving the longer packets in the list. Also, perform various
> +	 * prep/cleanup/error checking functions.
> +	 */
> +	skb->next = skb_shinfo(skb)->frag_list;
> +	skb_shinfo(skb)->frag_list = NULL;
> +	packets = skb;
> +	prev_link = &packets;
> +	for (skb = packets; skb; skb = next) {
> +		next = skb->next;
> +
> +		/* Make the header available at skb->data, even if the packet
> +		 * is fragmented. One complication: it's possible that the IP
> +		 * header hasn't yet been removed (this happens for GRO packets
> +		 * on the frag_list, since they aren't handled explicitly by IP.
> +		 */
> +		header_offset = skb_transport_header(skb) - skb->data;
> +		pull_length = HOMA_MAX_HEADER + header_offset;
> +		if (pull_length > skb->len)
> +			pull_length = skb->len;
> +		if (!pskb_may_pull(skb, pull_length))
> +			goto discard;
> +		if (header_offset)
> +			__skb_pull(skb, header_offset);
> +
> +		/* Reject packets that are too short or have bogus types. */
> +		h = (struct common_header *)skb->data;
> +		if (unlikely(skb->len < sizeof(struct common_header) ||
> +			     h->type < DATA || h->type >= BOGUS ||
> +			     skb->len < header_lengths[h->type - DATA]))
> +			goto discard;
> +
> +		if (first_packet)
> +			first_packet = 0;
> +
> +		/* Process the packet now if it is a control packet or
> +		 * if it contains an entire short message.
> +		 */
> +		if (h->type != DATA || ntohl(((struct data_header *)h)
> +				->message_length) < 1400) {
> +			*prev_link = skb->next;
> +			skb->next = NULL;
> +			homa_dispatch_pkts(skb, homa);
> +		} else {
> +			prev_link = &skb->next;
> +		}
> +		continue;
> +
> +discard:
> +		*prev_link = skb->next;
> +		kfree_skb(skb);
> +	}
> +
> +	/* Now process the longer packets. Each iteration of this loop
> +	 * collects all of the packets for a particular RPC and dispatches
> +	 * them.
> +	 */
> +	while (packets) {
> +		struct in6_addr saddr, saddr2;
> +		struct common_header *h2;
> +		struct sk_buff *skb2;
> +
> +		skb = packets;
> +		prev_link = &skb->next;
> +		saddr = skb_canonical_ipv6_saddr(skb);
> +		other_pkts = NULL;
> +		other_link = &other_pkts;
> +		h = (struct common_header *)skb->data;
> +		for (skb2 = skb->next; skb2; skb2 = next) {
> +			next = skb2->next;
> +			h2 = (struct common_header *)skb2->data;
> +			if (h2->sender_id == h->sender_id) {
> +				saddr2 = skb_canonical_ipv6_saddr(skb2);
> +				if (ipv6_addr_equal(&saddr, &saddr2)) {
> +					*prev_link = skb2;
> +					prev_link = &skb2->next;
> +					continue;
> +				}
> +			}
> +			*other_link = skb2;
> +			other_link = &skb2->next;
> +		}
> +		*prev_link = NULL;
> +		*other_link = NULL;
> +		homa_dispatch_pkts(packets, homa);
> +		packets = other_pkts;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * homa_backlog_rcv() - Invoked to handle packets saved on a socket's
> + * backlog because it was locked when the packets first arrived.
> + * @sk:     Homa socket that owns the packet's destination port.
> + * @skb:    The incoming packet. This function takes ownership of the packet
> + *          (we'll delete it).
> + *
> + * Return:  Always returns 0.
> + */
> +int homa_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> +{
> +	pr_warn("unimplemented backlog_rcv invoked on Homa socket\n");
> +	kfree_skb(skb);
> +	return 0;
> +}
> +
> +/**
> + * homa_err_handler_v4() - Invoked by IP to handle an incoming error
> + * packet, such as ICMP UNREACHABLE.
> + * @skb:   The incoming packet.
> + * @info:  Information about the error that occurred?
> + *
> + * Return: zero, or a negative errno if the error couldn't be handled here.
> + */
> +int homa_err_handler_v4(struct sk_buff *skb, u32 info)
> +{
> +	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
> +	const struct iphdr *iph = ip_hdr(skb);
> +	int type = icmp_hdr(skb)->type;
> +	int code = icmp_hdr(skb)->code;
> +
> +	if (type == ICMP_DEST_UNREACH && code == ICMP_PORT_UNREACH) {
> +		char *icmp = (char *)icmp_hdr(skb);
> +		struct common_header *h;
> +
> +		iph = (struct iphdr *)(icmp + sizeof(struct icmphdr));
> +		h = (struct common_header *)(icmp + sizeof(struct icmphdr)
> +				+ iph->ihl * 4);
> +		homa_abort_rpcs(homa, &saddr, ntohs(h->dport), -ENOTCONN);
> +	} else if (type == ICMP_DEST_UNREACH) {
> +		int error;
> +
> +		if (code == ICMP_PROT_UNREACH)
> +			error = -EPROTONOSUPPORT;
> +		else
> +			error = -EHOSTUNREACH;
> +		homa_abort_rpcs(homa, &saddr, 0, error);
> +	} else {
> +		pr_notice("%s invoked with info %x, ICMP type %d, ICMP code %d\n",
> +			  __func__, info, type, code);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * homa_err_handler_v6() - Invoked by IP to handle an incoming error
> + * packet, such as ICMP UNREACHABLE.
> + * @skb:    The incoming packet.
> + * @opt:    Not used.
> + * @type:   Type of ICMP packet.
> + * @code:   Additional information about the error.
> + * @offset: Not used.
> + * @info:   Information about the error that occurred?
> + *
> + * Return: zero, or a negative errno if the error couldn't be handled here.
> + */
> +int homa_err_handler_v6(struct sk_buff *skb, struct inet6_skb_parm *opt,
> +			u8 type,  u8 code,  int offset,  __be32 info)
> +{
> +	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
> +
> +	if (type == ICMPV6_DEST_UNREACH && code == ICMPV6_PORT_UNREACH) {
> +		char *icmp = (char *)icmp_hdr(skb);
> +		struct common_header *h;
> +
> +		iph = (struct ipv6hdr *)(icmp + sizeof(struct icmphdr));
> +		h = (struct common_header *)(icmp + sizeof(struct icmphdr)
> +				+ HOMA_IPV6_HEADER_LENGTH);
> +		homa_abort_rpcs(homa, &iph->daddr, ntohs(h->dport), -ENOTCONN);
> +	} else if (type == ICMPV6_DEST_UNREACH) {
> +		int error;
> +
> +		if (code == ICMP_PROT_UNREACH)
> +			error = -EPROTONOSUPPORT;
> +		else
> +			error = -EHOSTUNREACH;
> +		homa_abort_rpcs(homa, &iph->daddr, 0, error);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * homa_poll() - Invoked by Linux as part of implementing select, poll,
> + * epoll, etc.
> + * @file:  Open file that is participating in a poll, select, etc.
> + * @sock:  A Homa socket, associated with @file.
> + * @wait:  This table will be registered with the socket, so that it
> + *         is notified when the socket's ready state changes.
> + *
> + * Return: A mask of bits such as EPOLLIN, which indicate the current
> + *         state of the socket.
> + */
> +__poll_t homa_poll(struct file *file, struct socket *sock,
> +		   struct poll_table_struct *wait)
> +{
> +	struct sock *sk = sock->sk;
> +	__u32 mask;
> +
> +	/* It seems to be standard practice for poll functions *not* to
> +	 * acquire the socket lock, so we don't do it here; not sure
> +	 * why...
> +	 */
> +
> +	sock_poll_wait(file, sock, wait);
> +	mask = POLLOUT | POLLWRNORM;
> +
> +	if (!list_empty(&homa_sk(sk)->ready_requests) ||
> +	    !list_empty(&homa_sk(sk)->ready_responses))
> +		mask |= POLLIN | POLLRDNORM;
> +	return (__force __poll_t)mask;
> +}
> +
> +/**
> + * homa_hrtimer() - This function is invoked by the hrtimer mechanism to
> + * wake up the timer thread. Runs at IRQ level.
> + * @timer:   The timer that triggered; not used.
> + *
> + * Return:   Always HRTIMER_RESTART.
> + */
> +enum hrtimer_restart homa_hrtimer(struct hrtimer *timer)
> +{
> +	wake_up_process(timer_kthread);
> +	return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * homa_timer_main() - Top-level function for the timer thread.
> + * @transport:  Pointer to struct homa.
> + *
> + * Return:         Always 0.
> + */
> +int homa_timer_main(void *transport)
> +{
> +	struct homa *homa = (struct homa *)transport;
> +	struct hrtimer hrtimer;
> +	ktime_t tick_interval;
> +	u64 nsec;
> +
> +	hrtimer_init(&hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer.function = &homa_hrtimer;
> +	nsec = 1000000;                   /* 1 ms */
> +	tick_interval = ns_to_ktime(nsec);
> +	while (1) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (!exiting) {
> +			hrtimer_start(&hrtimer, tick_interval, HRTIMER_MODE_REL);
> +			schedule();
> +		}
> +		__set_current_state(TASK_RUNNING);
> +		if (exiting)
> +			break;
> +		homa_timer(homa);
> +	}
> +	hrtimer_cancel(&hrtimer);
> +	kthread_complete_and_exit(&timer_thread_done, 0);
> +	return 0;
> +}
> diff --git a/net/homa/homa_utils.c b/net/homa/homa_utils.c
> new file mode 100644
> index 000000000000..905d00c836bd
> --- /dev/null
> +++ b/net/homa/homa_utils.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/* This file contains miscellaneous utility functions for Homa, such
> + * as initializing and destroying homa structs.
> + */
> +
> +#include "homa_impl.h"
> +#include "homa_peer.h"
> +#include "homa_rpc.h"
> +#include "homa_stub.h"
> +
> +struct completion homa_pacer_kthread_done;
> +
> +/**
> + * homa_init() - Constructor for homa objects.
> + * @homa:   Object to initialize.
> + *
> + * Return:  0 on success, or a negative errno if there was an error. Even
> + *          if an error occurs, it is safe (and necessary) to call
> + *          homa_destroy at some point.
> + */
> +int homa_init(struct homa *homa)
> +{
> +	int err;
> +
> +	_Static_assert(HOMA_MAX_PRIORITIES >= 8,
> +		       "homa_init assumes at least 8 priority levels");
> +
> +	homa->pacer_kthread = NULL;
> +	init_completion(&homa_pacer_kthread_done);
> +	atomic64_set(&homa->next_outgoing_id, 2);
> +	atomic64_set(&homa->link_idle_time, sched_clock());
> +	spin_lock_init(&homa->pacer_mutex);
> +	homa->pacer_fifo_fraction = 50;
> +	homa->pacer_fifo_count = 1;
> +	homa->pacer_wake_time = 0;
> +	spin_lock_init(&homa->throttle_lock);
> +	INIT_LIST_HEAD_RCU(&homa->throttled_rpcs);
> +	homa->throttle_add = 0;
> +	homa->throttle_min_bytes = 200;
> +	homa->next_client_port = HOMA_MIN_DEFAULT_PORT;
> +	homa->port_map = kmalloc(sizeof(*homa->port_map), GFP_KERNEL);
> +	if (!homa->port_map) {
> +		pr_err("%s couldn't create port_map: kmalloc failure", __func__);
> +		return -ENOMEM;
> +	}
> +	homa_socktab_init(homa->port_map);
> +	homa->peers = kmalloc(sizeof(*homa->peers), GFP_KERNEL);
> +	if (!homa->peers) {
> +		pr_err("%s couldn't create peers: kmalloc failure", __func__);
> +		return -ENOMEM;
> +	}
> +	err = homa_peertab_init(homa->peers);
> +	if (err) {
> +		pr_err("%s couldn't initialize peer table (errno %d)\n",
> +		       __func__, -err);
> +		return err;
> +	}
> +
> +	/* Wild guesses to initialize configuration values... */
> +	homa->unsched_bytes = 40000;
> +	homa->window_param = 100000;
> +	homa->link_mbps = 25000;
> +	homa->fifo_grant_increment = 10000;
> +	homa->grant_fifo_fraction = 50;
> +	homa->max_overcommit = 8;
> +	homa->max_incoming = 400000;
> +	homa->max_rpcs_per_peer = 1;
> +	homa->resend_ticks = 5;
> +	homa->resend_interval = 5;
> +	homa->timeout_ticks = 100;
> +	homa->timeout_resends = 5;
> +	homa->request_ack_ticks = 2;
> +	homa->reap_limit = 10;
> +	homa->dead_buffs_limit = 5000;
> +	homa->max_dead_buffs = 0;
> +	homa->pacer_kthread = kthread_run(homa_pacer_main, homa,
> +					  "homa_pacer");
> +	if (IS_ERR(homa->pacer_kthread)) {
> +		err = PTR_ERR(homa->pacer_kthread);
> +		homa->pacer_kthread = NULL;
> +		pr_err("couldn't create homa pacer thread: error %d\n", err);
> +		return err;
> +	}
> +	homa->pacer_exit = false;
> +	homa->max_nic_queue_ns = 5000;
> +	homa->ns_per_mbyte = 0;
> +	homa->max_gso_size = 10000;
> +	homa->gso_force_software = 0;
> +	homa->max_gro_skbs = 20;
> +	homa->gro_policy = HOMA_GRO_NORMAL;
> +	homa->timer_ticks = 0;
> +	homa->flags = 0;
> +	homa->bpage_lease_usecs = 10000;
> +	homa->next_id = 0;
> +	homa_outgoing_sysctl_changed(homa);
> +	homa_incoming_sysctl_changed(homa);
> +	return 0;
> +}
> +
> +/**
> + * homa_destroy() -  Destructor for homa objects.
> + * @homa:      Object to destroy.
> + */
> +void homa_destroy(struct homa *homa)
> +{
> +	if (homa->pacer_kthread) {
> +		homa_pacer_stop(homa);
> +		wait_for_completion(&homa_pacer_kthread_done);
> +	}
> +
> +	/* The order of the following statements matters! */
> +	if (homa->port_map) {
> +		homa_socktab_destroy(homa->port_map);
> +		kfree(homa->port_map);
> +		homa->port_map = NULL;
> +	}
> +	if (homa->peers) {
> +		homa_peertab_destroy(homa->peers);
> +		kfree(homa->peers);
> +		homa->peers = NULL;
> +	}
> +}
> +
> +/**
> + * homa_spin() - Delay (without sleeping) for a given time interval.
> + * @ns:   How long to delay (in nanoseconds)
> + */
> +void homa_spin(int ns)
> +{
> +	__u64 end;
> +
> +	end = sched_clock() + ns;
> +	while (sched_clock() < end)
> +		/* Empty loop body.*/
> +		;
> +}
> +
> +/**
> + * homa_throttle_lock_slow() - This function implements the slow path for
> + * acquiring the throttle lock. It is invoked when the lock isn't immediately
> + * available. It waits for the lock, but also records statistics about
> + * the waiting time.
> + * @homa:    Overall data about the Homa protocol implementation.
> + */
> +void homa_throttle_lock_slow(struct homa *homa)
> +	__acquires(&homa->throttle_lock)
> +{
> +	spin_lock_bh(&homa->throttle_lock);
> +}

