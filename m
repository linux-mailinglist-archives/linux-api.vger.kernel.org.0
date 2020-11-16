Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EE02B44D8
	for <lists+linux-api@lfdr.de>; Mon, 16 Nov 2020 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgKPNgH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 08:36:07 -0500
Received: from foss.arm.com ([217.140.110.172]:39870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgKPNgH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 16 Nov 2020 08:36:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D83C9101E;
        Mon, 16 Nov 2020 05:36:06 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52563F70D;
        Mon, 16 Nov 2020 05:36:04 -0800 (PST)
Date:   Mon, 16 Nov 2020 13:36:01 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v16 6/6] arm64: expose FAR_EL1 tag bits in siginfo
Message-ID: <20201116133600.GY6882@arm.com>
References: <cover.1605235762.git.pcc@google.com>
 <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
 <87ft5an257.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft5an257.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Nov 15, 2020 at 08:08:36AM -0600, Eric W. Biederman wrote:
> Peter Collingbourne <pcc@google.com> writes:
> 
> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > the tag bits may be needed by tools in order to accurately diagnose
> > memory errors, such as HWASan [1] or future tools based on the Memory
> > Tagging Extension (MTE).
> >
> > We should not stop clearing these bits in the existing fault address
> > fields, because there may be existing userspace applications that are
> > expecting the tag bits to be cleared. Instead, introduce a flag in
> > sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
> > there if the signal handler has this flag set.
> 
> For future architectures that implement something similar does it make
> sense that to hide tag bits by default?

I think on arm64 this comes from the fact that the tag bits information
is not available in all scenarios.  To keep things clean, the decision
was taken early on to just zero them all the time in si_addr to avoid
software getting confused.  Possibly other arches do something similar,
but that would need digging into.

There seems to be debate on whether these bits are part of the address
or not.  For si_addr I think they probably _should_ be regarded as part
of the address in general, and arches that can always report all these
bits in si_addr should probably do so IMHO.

> I am wondering if SA_EXPOSE_TABGITS might make sense as an architecture
> specific sa bit.

Perhaps.  Peter, do you see other arches masking out bits in si_addr?

[...]

Cheers
---Dave
