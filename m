Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B53628D6
	for <lists+linux-api@lfdr.de>; Fri, 16 Apr 2021 21:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbhDPTpG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Apr 2021 15:45:06 -0400
Received: from mail132-17.atl131.mandrillapp.com ([198.2.132.17]:34656 "EHLO
        mail132-17.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235590AbhDPTpG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Apr 2021 15:45:06 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2021 15:45:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=tW3n4iXTwRJ8zOqIkbHUARclgCzpKeFKhfYKy43eRDE=;
 b=P0mMWoowDsh1jrezbjzIEsdDtUjrYd1jpnHF+ryGMyW3CaMHVR00+kBLWg8jaHbg2ZJ9wi4J2jbm
   s2Jiqsq8G+Hp2yPVhLqhldQay4Gw67lr2YWZaAktrqhfVJF924tbOvkQi9iJRPZ2gAWO70cSqb86
   J1cGytl0KQKn0sNpAvc=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail132-17.atl131.mandrillapp.com id hf7kii1sar89 for <linux-api@vger.kernel.org>; Fri, 16 Apr 2021 19:29:40 +0000 (envelope-from <bounce-md_31050260.6079e5a4.v1-9565fa8ee40c40e697cd14dca4df751b@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1618601380; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=tW3n4iXTwRJ8zOqIkbHUARclgCzpKeFKhfYKy43eRDE=; 
 b=Kv1At2U8sD0ycm0F3TovTWy6HGwuAcjW2hiiwzRJWIrlOud7MlqXP7A7YEngUamdzT8o0P
 vsaIVPngmpeHxs5/PxXbIXmlR5Dmxejnb5hsCrdaK1+Xv6b+y9sPIvg4MeODtT+RW5GprzvA
 CeRFe0z9B4h1X3nu8ZbDUBMhno2bg=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another address space
Received: from [87.98.221.171] by mandrillapp.com id 9565fa8ee40c40e697cd14dca4df751b; Fri, 16 Apr 2021 19:29:40 +0000
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Message-Id: <YHnlmm7mK3tmxcdr@deco.navytux.spb.ru>
References: <20210414055217.543246-1-avagin@gmail.com>
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.9565fa8ee40c40e697cd14dca4df751b
X-Mandrill-User: md_31050260
Date:   Fri, 16 Apr 2021 19:29:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 13, 2021 at 10:52:13PM -0700, Andrei Vagin wrote:
> We already have process_vm_readv and process_vm_writev to read and write
> to a process memory faster than we can do this with ptrace. And now it
> is time for process_vm_exec that allows executing code in an address
> space of another process. We can do this with ptrace but it is much
> slower.

I'd like to add that there are cases when using ptrace is even hardly possible:
in my situation one process needs to modify address space of another process
while that target process is being blocked under pagefault. From
https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/notes.txt#L149-171 ,
https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/wcfs.go#L395-397 :

---- 8< ----
Client cannot be ptraced while under pagefault
==============================================

We cannot use ptrace to run code on client thread that is under pagefault:

The kernel sends SIGSTOP to interrupt tracee, but the signal will be
processed only when the process returns from kernel space, e.g. here

     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/entry/common.c?id=v4.19-rc8-151-g23469de647c4#n160

This way the tracer won't receive obligatory information that tracee
stopped (via wait...) and even though ptrace(ATTACH) succeeds, all other
ptrace commands will fail:

     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/ptrace.c?id=v4.19-rc8-151-g23469de647c4#n1140
     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/ptrace.c?id=v4.19-rc8-151-g23469de647c4#n207

My original idea was to use ptrace to run code in process to change it's
memory mappings, while the triggering process is under pagefault/read
to wcfs, and the above shows it won't work - trying to ptrace the
client from under wcfs will just block forever (the kernel will be
waiting for read operation to finish for ptrace, and read will be first
waiting on ptrace stopping to complete = deadlock)

...

//	( one could imagine adjusting mappings synchronously via running
//	  wcfs-trusted code via ptrace that wcfs injects into clients, but ptrace
//	  won't work when client thread is blocked under pagefault or syscall(^) )
---- 8< ----

To workaround that I need to add special thread into target process and
implement custom additional "isolation protocol" in between my filesystem and
client processes that use it:

https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/wcfs.go#L94-182
https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/client/wcfs.h#L20-96
https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/client/wcfs.cpp#L24-203

Most parts of that dance would be much easier, or completely
unnecessary, if it could be possible to reliably make changes to address
space of target process from outside.

Kirill
