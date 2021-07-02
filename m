Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582A93BA608
	for <lists+linux-api@lfdr.de>; Sat,  3 Jul 2021 00:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhGBWrQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 18:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233249AbhGBWrP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 2 Jul 2021 18:47:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88B1D61369;
        Fri,  2 Jul 2021 22:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625265883;
        bh=VAS+i7j9RsZ5DMKojNBUf0k3To0kIZtOvo7yvM1oi8w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dD0DozhQq7Qa778vxZIqWGs+qXclDLvCdjAF/3bHkz1/HbJEX8RMbAqV7L08WQ3D9
         p5TQhcRdav3lunVo3DljPtUD5d/CX/y/A+ybJW8U7+WsIFZeV5AFu9lhICMuRGJhzo
         2iUu5aPzwJtW1ZipB4zChrDyLLqTOt2AKk5Mub4GgU40xW8Xn/IDdiO5MIuOTEK8Vm
         ssM7dNIyHlzjgvHGDabsNNa5E0qmSUEC5Qn/7Iu0SaBXuU1YqwxEBbOV6mp5bqzb7Y
         4i0QQ2mcNWbS1oRiPTiRM+Tyubz2xmwDHty6m2wBCw9zHO3ehs09NwTwiDYxLspJhf
         /e6zPWovD4/Bw==
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
To:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
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
References: <20210414055217.543246-1-avagin@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <6073e4c6-6fe8-0448-4586-5d04d7154164@kernel.org>
Date:   Fri, 2 Jul 2021 15:44:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/13/21 10:52 PM, Andrei Vagin wrote:

> process_vm_exec has two modes:
> 
> * Execute code in an address space of a target process and stop on any
>   signal or system call.

We already have a perfectly good context switch mechanism: context
switches.  If you execute code, you are basically guaranteed to be
subject to being hijacked, which means you pretty much can't allow
syscalls.  But there's a lot of non-syscall state, and I think context
switching needs to be done with extreme care.

(Just as example, suppose you switch mms, then set %gs to point to the
LDT, then switch back.  Now you're in a weird state.  With %ss the plot
is a bit thicker.  And there are emulated vsyscalls and such.)

If you, PeterZ, and the UMCG could all find an acceptable, efficient way
to wake-and-wait so you can switch into an injected task in the target
process and switch back quickly, then I think a much nicer solution will
become available.

> 
> * Execute a system call in an address space of a target process.

I could get behind this, but there are plenty of cans of worms to watch
out for.  Serious auditing would be needed.
