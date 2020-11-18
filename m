Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5C2B83B2
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgKRSS2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 13:18:28 -0500
Received: from foss.arm.com ([217.140.110.172]:33194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgKRSS2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Nov 2020 13:18:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79AC911D4;
        Wed, 18 Nov 2020 10:18:27 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4E9E3F718;
        Wed, 18 Nov 2020 10:18:25 -0800 (PST)
Date:   Wed, 18 Nov 2020 18:18:22 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     libc-alpha@sourceware.org, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201118181821.GJ6882@arm.com>
References: <20201014055106.25164-1-pcc@google.com>
 <87blfv6fj3.fsf@mid.deneb.enyo.de>
 <20201118171945.GG6882@arm.com>
 <874klmvafq.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874klmvafq.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 18, 2020 at 06:31:21PM +0100, Florian Weimer wrote:
> * Dave Martin:
> 
> > IIUC the default compiler options when using PAC will only use the
> > A key, and only use the PAC instructions that execute as NOPs when the
> > affected key is disabled (precisely so that the code still runs on non-
> > PAC supporting hardware).  But you can't simply flip it on and off while
> > there are function frames on the stack that assume it's either on or off.
> 
> I think we can do the switch at the top-most frame, at least in ld.so.
> I have not thought about statically linked binaries. 8-/

I guess that's one argument for doing this in the kernel, if it can be
done in a compatible way.

We might want an antiproperty for this: so ..._PAC means that PAC is
used and _PAC|_NOIBKEY|_NODBKEY etc. disables specific keys.  
(With no flags, we could keep the legacy behaviour of just enabling all
the keys, but the program might not use PAC at all.)

Alternatively, if the linker provides symbols for the property section,
maybe the libc startup could inspect it?  I think this section is mapped
to PT_LOAD segment in practice.

Cheers
--Dave
