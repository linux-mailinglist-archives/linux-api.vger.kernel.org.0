Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470BB35EE7C
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348707AbhDNHfN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347823AbhDNHfM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 03:35:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72989C061574;
        Wed, 14 Apr 2021 00:34:51 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lWa2r-00BW2q-RV; Wed, 14 Apr 2021 09:34:42 +0200
Message-ID: <9f8280540bbc6f3c857ac5749eeafcd145577da3.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Benjamin Berg <benjamin@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 14 Apr 2021 09:34:40 +0200
In-Reply-To: <78cdee11-1923-595f-90d2-e236efbafa6a@cambridgegreys.com>
References: <20210414055217.543246-1-avagin@gmail.com>
         <78cdee11-1923-595f-90d2-e236efbafa6a@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 2021-04-14 at 08:22 +0100, Anton Ivanov wrote:
> On 14/04/2021 06:52, Andrei Vagin wrote:
> > We already have process_vm_readv and process_vm_writev to read and write
> > to a process memory faster than we can do this with ptrace. And now it
> > is time for process_vm_exec that allows executing code in an address
> > space of another process. We can do this with ptrace but it is much
> > slower.
> > 
> > = Use-cases =
> > 
> > Here are two known use-cases. The first one is “application kernel”
> > sandboxes like User-mode Linux and gVisor. In this case, we have a
> > process that runs the sandbox kernel and a set of stub processes that
> > are used to manage guest address spaces. Guest code is executed in the
> > context of stub processes but all system calls are intercepted and
> > handled in the sandbox kernel. Right now, these sort of sandboxes use
> > PTRACE_SYSEMU to trap system calls, but the process_vm_exec can
> > significantly speed them up.
> 
> Certainly interesting, but will require um to rework most of its memory 
> management and we will most likely need extra mm support to make use of 
> it in UML. We are not likely to get away just with one syscall there.

Might help the seccomp mode though:

https://patchwork.ozlabs.org/project/linux-um/list/?series=231980

johannes


