Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E71E8E3F
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfJ2RhS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 13:37:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:18881 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfJ2RhS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Oct 2019 13:37:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 10:37:17 -0700
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; 
   d="scan'208";a="193678661"
Received: from acox1-desk1.ger.corp.intel.com ([10.251.81.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 10:37:13 -0700
Message-ID: <57f25261400464ea58b65bf39ca1b4f89eea2ce2.camel@linux.intel.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
From:   Alan Cox <alan@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tycho Andersen <tycho@tycho.ws>
Date:   Tue, 29 Oct 2019 17:37:10 +0000
In-Reply-To: <CALCETrWN9kc+10tf7YoBp9ixqkO_KZ=b1E_cFBr_Uogxhu68PQ@mail.gmail.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
         <2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com>
         <CALCETrWN9kc+10tf7YoBp9ixqkO_KZ=b1E_cFBr_Uogxhu68PQ@mail.gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> Doing all of this with MAP_SECRET seems bad to me.  If user code
> wants
> UC memory, it should ask for UC memory -- having the kernel involved
> in the decision to use UC memory is a bad idea, because the
> performance impact of using UC memory where user code wasn't
> expecting

The user has no idea that they want UC memory. It varies by platform
what this means. There are some systems (eg in order uclinux devices,
M68K, old atoms) for which it probably means 'no-op', there are those
where UC helps, those it hinders, there are those where WC is probably
sufficient. There are platforms where 'secret' memory might best be
implemented by using on die memory pools or cache locking. It might
even mean 'put me in a non HT cgroup'.

Secret might also mean 'not accessible by thunderbolt', or 'do not swap
unless swap is encrypted' and other things.

IMHO the question is what is the actual semantic here. What are you
asking for ? Does it mean "at any cost", what does it guarantee (100%
or statistically), what level of guarantee is acceptable, what level is
-EOPNOTSUPP or similar ?

I'm also wary of the focus always being on keys. If you decrypt a file
I'm probably just as interested in the contents so can I mmap a file
this way and if so what happens on the unmap. Yes key theft lets me do
all sorts of theoretical long term bad stuff, but frequently data theft
is sufficient to do lots of practical short term bad stuff. Also as an
attacker I'm probably a script, and I don't want to be exposing my
master long term because they want the footprints gone.

> in gnome-shell.  The system slowed down to such an extent that I was
> unable to enter the three or so keystrokes to turn it back off.)

Yes - and any uncached pages also need to be kept away from anything
that the kernel touches under locks, or use in atomic user operations
stuff. Copy on write of an uncached page for example is suddenly really
slow and there are so many other cases we'd have to find and deal with.

> EXCLUSIVE makes sense.  Saying "don't ptrace this" makes sense.  UC
> makes sense.  But having one flag to rule them all does not make
> sense
> to me.

We already support not ptracing, and if I can ptrace any of the code I
can access all of its code/data so that one isn't hard and the LSM
interfaces can do it. That one is easy - minus the fact that malware
writers are big fans of anything that stops tracing...

Alan


