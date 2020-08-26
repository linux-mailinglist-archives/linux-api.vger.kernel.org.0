Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D982537C2
	for <lists+linux-api@lfdr.de>; Wed, 26 Aug 2020 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHZTBg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Aug 2020 15:01:36 -0400
Received: from albireo.enyo.de ([37.24.231.21]:37884 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgHZTBc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 26 Aug 2020 15:01:32 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kB0fd-00039M-Py; Wed, 26 Aug 2020 19:01:17 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kB0fd-0004bF-Mv; Wed, 26 Aug 2020 21:01:17 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova\, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH] mm: extend memfd with ability to create "secret" memory areas
References: <20200130162340.GA14232@rapoport-lnx>
        <CALCETrVOWodgnRBFpPLEnc_Bfg=fgfAJiD1p-eE1uwCMc6c9Tg@mail.gmail.com>
        <6e020a65-b516-9407-228f-2a3a32947ab9@intel.com>
        <CALCETrUwO_y_b=kazRjen-de50r9b9TVXUXz_WT_hD3d3tTWxQ@mail.gmail.com>
Date:   Wed, 26 Aug 2020 21:01:17 +0200
In-Reply-To: <CALCETrUwO_y_b=kazRjen-de50r9b9TVXUXz_WT_hD3d3tTWxQ@mail.gmail.com>
        (Andy Lutomirski's message of "Wed, 26 Aug 2020 09:54:57 -0700")
Message-ID: <87y2m1qlj6.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Andy Lutomirski:

>> I _believe_ there are also things like AES-NI that can get strong
>> protection from stuff like this.  They load encryption keys into (AVX)
>> registers and then can do encrypt/decrypt operations without the keys
>> leaving the registers.  If the key was loaded from a secret memory area
>> right into the registers, I think the protection from cache attacks
>> would be pretty strong.
>
> Except for context switches :)

An rseq sequence could request that the AVX registers should be
cleared on context switch.  (I'm mostly kidding.)

I think the main issue is that we do not have a good established
programming model to actually use such features and completely avoid
making copies of secret data.
