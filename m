Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D51235334
	for <lists+linux-api@lfdr.de>; Sat,  1 Aug 2020 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgHAQIX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 1 Aug 2020 12:08:23 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33540 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAQIX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 1 Aug 2020 12:08:23 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4C44372CCE9;
        Sat,  1 Aug 2020 19:08:19 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 3AB947CFC00; Sat,  1 Aug 2020 19:08:19 +0300 (MSK)
Date:   Sat, 1 Aug 2020 19:08:19 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <evgsyr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v3] ptrace: Prevent
 kernel-infoleak in ptrace_get_syscall_info()
Message-ID: <20200801160818.GB4964@altlinux.org>
References: <20200801020841.227522-1-yepeilin.cs@gmail.com>
 <20200801152044.230416-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801152044.230416-1-yepeilin.cs@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Aug 01, 2020 at 11:20:44AM -0400, Peilin Ye wrote:
> ptrace_get_syscall_info() is potentially copying uninitialized stack
> memory to userspace, since the compiler may leave a 3-byte hole near the
> beginning of `info`. Fix it by adding a padding field to `struct
> ptrace_syscall_info`.
> 
> Cc: stable@vger.kernel.org
> Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> Change in v3:
>     - Remove unnecessary `__aligned__` attribute. (Suggested by
>       Dmitry V. Levin <ldv@altlinux.org>)
> 
> Change in v2:
>     - Add a padding field to `struct ptrace_syscall_info`, instead of
>       doing memset() on `info`. (Suggested by Dmitry V. Levin
>       <ldv@altlinux.org>)
> 
> Reference: https://lwn.net/Articles/417989/
> 
> $ # before:
> $ pahole -C "ptrace_syscall_info" kernel/ptrace.o
> struct ptrace_syscall_info {
> 	__u8                       op;                   /*     0     1 */
> 
> 	/* XXX 3 bytes hole, try to pack */
> 
> 	__u32                      arch __attribute__((__aligned__(4))); /*     4     4 */
> 	__u64                      instruction_pointer;  /*     8     8 */
> 	__u64                      stack_pointer;        /*    16     8 */
> 	union {
> 		struct {
> 			__u64      nr;                   /*    24     8 */
> 			__u64      args[6];              /*    32    48 */
> 		} entry;                                 /*    24    56 */
> 		struct {
> 			__s64      rval;                 /*    24     8 */
> 			__u8       is_error;             /*    32     1 */
> 		} exit;                                  /*    24    16 */
> 		struct {
> 			__u64      nr;                   /*    24     8 */
> 			__u64      args[6];              /*    32    48 */
> 			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> 			__u32      ret_data;             /*    80     4 */
> 		} seccomp;                               /*    24    64 */
> 	};                                               /*    24    64 */
> 
> 	/* size: 88, cachelines: 2, members: 5 */
> 	/* sum members: 85, holes: 1, sum holes: 3 */
> 	/* forced alignments: 1, forced holes: 1, sum forced holes: 3 */
> 	/* last cacheline: 24 bytes */
> } __attribute__((__aligned__(8)));
> $
> $ # after:
> $ pahole -C "ptrace_syscall_info" kernel/ptrace.o
> struct ptrace_syscall_info {
> 	__u8                       op;                   /*     0     1 */
> 	__u8                       pad[3];               /*     1     3 */
> 	__u32                      arch;                 /*     4     4 */
> 	__u64                      instruction_pointer;  /*     8     8 */
> 	__u64                      stack_pointer;        /*    16     8 */
> 	union {
> 		struct {
> 			__u64      nr;                   /*    24     8 */
> 			__u64      args[6];              /*    32    48 */
> 		} entry;                                 /*    24    56 */
> 		struct {
> 			__s64      rval;                 /*    24     8 */
> 			__u8       is_error;             /*    32     1 */
> 		} exit;                                  /*    24    16 */
> 		struct {
> 			__u64      nr;                   /*    24     8 */
> 			__u64      args[6];              /*    32    48 */
> 			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> 			__u32      ret_data;             /*    80     4 */
> 		} seccomp;                               /*    24    64 */
> 	};                                               /*    24    64 */
> 
> 	/* size: 88, cachelines: 2, members: 6 */
> 	/* last cacheline: 24 bytes */
> };
> $ _
> 
>  include/uapi/linux/ptrace.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index a71b6e3b03eb..83ee45fa634b 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -81,7 +81,8 @@ struct seccomp_metadata {
>  
>  struct ptrace_syscall_info {
>  	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> -	__u32 arch __attribute__((__aligned__(sizeof(__u32))));
> +	__u8 pad[3];
> +	__u32 arch;
>  	__u64 instruction_pointer;
>  	__u64 stack_pointer;
>  	union {

Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>

Thanks,


-- 
ldv
