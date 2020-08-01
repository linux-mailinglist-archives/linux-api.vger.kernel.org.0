Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FC623543C
	for <lists+linux-api@lfdr.de>; Sat,  1 Aug 2020 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgHAUK2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 1 Aug 2020 16:10:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42887 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAUK2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 1 Aug 2020 16:10:28 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k1xpe-00044g-DI; Sat, 01 Aug 2020 20:10:14 +0000
Date:   Sat, 1 Aug 2020 22:10:13 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <evgsyr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v3] ptrace: Prevent
 kernel-infoleak in ptrace_get_syscall_info()
Message-ID: <20200801201013.gjqj4digttp2rtmj@wittgenstein>
References: <20200801020841.227522-1-yepeilin.cs@gmail.com>
 <20200801152044.230416-1-yepeilin.cs@gmail.com>
 <20200801160818.GB4964@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200801160818.GB4964@altlinux.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Aug 01, 2020 at 07:08:19PM +0300, Dmitry V. Levin wrote:
> On Sat, Aug 01, 2020 at 11:20:44AM -0400, Peilin Ye wrote:
> > ptrace_get_syscall_info() is potentially copying uninitialized stack
> > memory to userspace, since the compiler may leave a 3-byte hole near the
> > beginning of `info`. Fix it by adding a padding field to `struct
> > ptrace_syscall_info`.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > ---
> > Change in v3:
> >     - Remove unnecessary `__aligned__` attribute. (Suggested by
> >       Dmitry V. Levin <ldv@altlinux.org>)
> > 
> > Change in v2:
> >     - Add a padding field to `struct ptrace_syscall_info`, instead of
> >       doing memset() on `info`. (Suggested by Dmitry V. Levin
> >       <ldv@altlinux.org>)
> > 
> > Reference: https://lwn.net/Articles/417989/
> > 
> > $ # before:
> > $ pahole -C "ptrace_syscall_info" kernel/ptrace.o
> > struct ptrace_syscall_info {
> > 	__u8                       op;                   /*     0     1 */
> > 
> > 	/* XXX 3 bytes hole, try to pack */
> > 
> > 	__u32                      arch __attribute__((__aligned__(4))); /*     4     4 */
> > 	__u64                      instruction_pointer;  /*     8     8 */
> > 	__u64                      stack_pointer;        /*    16     8 */
> > 	union {
> > 		struct {
> > 			__u64      nr;                   /*    24     8 */
> > 			__u64      args[6];              /*    32    48 */
> > 		} entry;                                 /*    24    56 */
> > 		struct {
> > 			__s64      rval;                 /*    24     8 */
> > 			__u8       is_error;             /*    32     1 */
> > 		} exit;                                  /*    24    16 */
> > 		struct {
> > 			__u64      nr;                   /*    24     8 */
> > 			__u64      args[6];              /*    32    48 */
> > 			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> > 			__u32      ret_data;             /*    80     4 */
> > 		} seccomp;                               /*    24    64 */
> > 	};                                               /*    24    64 */
> > 
> > 	/* size: 88, cachelines: 2, members: 5 */
> > 	/* sum members: 85, holes: 1, sum holes: 3 */
> > 	/* forced alignments: 1, forced holes: 1, sum forced holes: 3 */
> > 	/* last cacheline: 24 bytes */
> > } __attribute__((__aligned__(8)));
> > $
> > $ # after:
> > $ pahole -C "ptrace_syscall_info" kernel/ptrace.o
> > struct ptrace_syscall_info {
> > 	__u8                       op;                   /*     0     1 */
> > 	__u8                       pad[3];               /*     1     3 */
> > 	__u32                      arch;                 /*     4     4 */
> > 	__u64                      instruction_pointer;  /*     8     8 */
> > 	__u64                      stack_pointer;        /*    16     8 */
> > 	union {
> > 		struct {
> > 			__u64      nr;                   /*    24     8 */
> > 			__u64      args[6];              /*    32    48 */
> > 		} entry;                                 /*    24    56 */
> > 		struct {
> > 			__s64      rval;                 /*    24     8 */
> > 			__u8       is_error;             /*    32     1 */
> > 		} exit;                                  /*    24    16 */
> > 		struct {
> > 			__u64      nr;                   /*    24     8 */
> > 			__u64      args[6];              /*    32    48 */
> > 			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> > 			__u32      ret_data;             /*    80     4 */
> > 		} seccomp;                               /*    24    64 */
> > 	};                                               /*    24    64 */
> > 
> > 	/* size: 88, cachelines: 2, members: 6 */
> > 	/* last cacheline: 24 bytes */
> > };
> > $ _
> > 
> >  include/uapi/linux/ptrace.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> > index a71b6e3b03eb..83ee45fa634b 100644
> > --- a/include/uapi/linux/ptrace.h
> > +++ b/include/uapi/linux/ptrace.h
> > @@ -81,7 +81,8 @@ struct seccomp_metadata {
> >  
> >  struct ptrace_syscall_info {
> >  	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> > -	__u32 arch __attribute__((__aligned__(sizeof(__u32))));
> > +	__u8 pad[3];
> > +	__u32 arch;
> >  	__u64 instruction_pointer;
> >  	__u64 stack_pointer;
> >  	union {
> 
> Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Oh fun.
I'd pick this up and run the ptrace tests that we have for this. If they
pass I'd apply to my fixes branch and send after the merge window unless
I hear objections.

Fwiw, what was the original reason for using
__attribute__((__aligned__(sizeof(__u32))))?
b4 mbox is failing to download the relevant thread(s) for me.

Thanks!
Christian
