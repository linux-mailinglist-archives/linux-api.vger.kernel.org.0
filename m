Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCAA319D07
	for <lists+linux-api@lfdr.de>; Fri, 12 Feb 2021 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBLLD6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Feb 2021 06:03:58 -0500
Received: from foss.arm.com ([217.140.110.172]:35142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhBLLB4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 12 Feb 2021 06:01:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 366CD113E;
        Fri, 12 Feb 2021 03:01:10 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D54B3F719;
        Fri, 12 Feb 2021 03:01:08 -0800 (PST)
Subject: Re: [PATCH v6 3/3] arm64: pac: Optimize kernel entry/exit key
 installation code paths
To:     Peter Collingbourne <pcc@google.com>, Will Deacon <will@kernel.org>
Cc:     libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgenii Stepanov <eugenis@google.com>
References: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
 <e3977b3e1b548be1d9554ccfad6c83ac87802583.1609311499.git.pcc@google.com>
 <20210126130947.GD29702@willie-the-truck>
 <CAMn1gO4OGsYYXBAWk=OiauZoyHoPFR9znSeLfXV0rLoZ+H7j1A@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c314e144-26d7-d80c-ce83-5fd597a8f772@arm.com>
Date:   Fri, 12 Feb 2021 11:01:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMn1gO4OGsYYXBAWk=OiauZoyHoPFR9znSeLfXV0rLoZ+H7j1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

On 12/02/2021 05:01, Peter Collingbourne wrote:
> On Tue, Jan 26, 2021 at 5:09 AM Will Deacon <will@kernel.org> wrote:
>>
>> On Tue, Dec 29, 2020 at 10:59:15PM -0800, Peter Collingbourne wrote:
>>> The kernel does not use any keys besides IA so we don't need to
>>> install IB/DA/DB/GA on kernel exit if we arrange to install them
>>> on task switch instead, which we can expect to happen an order of
>>> magnitude less often.
>>>
>>> Furthermore we can avoid installing the user IA in the case where the
>>> user task has IA disabled and just leave the kernel IA installed. This
>>> also lets us avoid needing to install IA on kernel entry.
>>
>> I've got to be honest, this makes me nervous in case there is a way for
>> userspace to recover the kernel key even though EnIA is clear. Currently,
>> EnIA doesn't affect XPAC* and PACGA instructions, and the architecture

> For GA I would expect it to be controlled by a hypothetical EnGA, not
> by EnIA (and I'm a bit surprised that there isn't an EnGA;

PACGA is undefined if the CPU doesn't implement PAC, whereas PACIASP is a NOP if the CPU
doesn't implement PAC.

I think the reason from the SCTLR_ELx controls is to make unaware systems transform the
instructions that were hints back into hints. (e.g. the AddPACIA psuedo code). This is
needed on mismatched big-little systems, otherwise processes can't be migrated between them.

For the non-hint instructions, user-space needs to test the hwcap/id-register-emulation to
know it can use these instructions, and the compiler shouldn't output them unconditionally.


> doesn't it
> mean that a userspace program running under an unaware kernel or
> hypervisor may sign things using the GA from potentially another
> hypervisor guest?)

The hypervisor controls all this with HCR_EL2.API, which also traps PACGA et al.
For the hypervisor its all or nothing.
If the hypervisor is emulating a machine without PAC, it can emulate an undefined
exception regardless of whether the CPU supports PAC or not.

Does this match your reading?


Thanks,

James
