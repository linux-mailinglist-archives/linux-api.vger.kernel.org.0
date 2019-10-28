Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF0E7A02
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 21:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfJ1UXZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 16:23:25 -0400
Received: from albireo.enyo.de ([37.24.231.21]:46696 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfJ1UXY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 28 Oct 2019 16:23:24 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iPBXp-0006Lq-Li; Mon, 28 Oct 2019 20:23:17 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iPBXp-0005JX-J5; Mon, 28 Oct 2019 21:23:17 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
        <87d0eieb0i.fsf@mid.deneb.enyo.de>
        <385EB6D4-A1B0-4617-B256-181AA1C3BDE3@kernel.org>
Date:   Mon, 28 Oct 2019 21:23:17 +0100
In-Reply-To: <385EB6D4-A1B0-4617-B256-181AA1C3BDE3@kernel.org> (Mike
        Rapoport's message of "Sun, 27 Oct 2019 13:00:13 +0200")
Message-ID: <87h83s62mi.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mike Rapoport:

> On October 27, 2019 12:30:21 PM GMT+02:00, Florian Weimer
> <fw@deneb.enyo.de> wrote:
>>* Mike Rapoport:
>>
>>> The patch below aims to allow applications to create mappins that
>>have
>>> pages visible only to the owning process. Such mappings could be used
>>to
>>> store secrets so that these secrets are not visible neither to other
>>> processes nor to the kernel.
>>
>>How is this expected to interact with CRIU?
>
> CRIU dumps the memory contents using a parasite code from inside the
> dumpee address space, so it would work the same way as for the other
> mappings. Of course, at the restore time the exclusive mapping should
> be recreated with the appropriate flags.

Hmm, so it would use a bounce buffer to perform the extraction?

>>> I've only tested the basic functionality, the changes should be
>>verified
>>> against THP/migration/compaction. Yet, I'd appreciate early feedback.
>>
>>What are the expected semantics for VM migration?  Should it fail?
>
> I don't quite follow. If qemu would use such mappings it would be able
> to transfer them during live migration.

I was wondering if the special state is supposed to bubble up to the
host eventually.
