Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6055AE99A7
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 11:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfJ3KEq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 06:04:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfJ3KEq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Oct 2019 06:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k4pc/iMWUhnLptKqwUE4lPn7l5icEmFDqp2yizhA38o=; b=k8bDC5IW7yDWjoy94bRZqyVvl
        YGcEQxUqCyZunYCwEAnVro6R0yoIKAbmS236ylADPR/HMUjrQYMV1ZcUb3/NSSn/YURlKJYAteYDw
        3eHeFCUiZOlBGRR/NMVTWqnmc4CPTjUdMG5M00fBZRUpaEIQEBsTHTjdbsBOgEVwTAg+3KDgvfbCY
        k4c3HpZuAjB1OPateFke9CbRcII8C1PvsdHh7n+HLO1pOoCxkFfXadIaMVJHyA85k2MxEwqqsruBP
        26rfWxj4kRYQQH6W4I78FtUuo+zcNFzsME30YSJ0uxJcH7qRZUt9X3AbsMPTCXIw/UjOctKD3cswE
        RBe8ZqPtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPkpw-0007Ha-5H; Wed, 30 Oct 2019 10:04:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54D4B30610C;
        Wed, 30 Oct 2019 11:03:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 722EF2B4574F5; Wed, 30 Oct 2019 11:04:18 +0100 (CET)
Date:   Wed, 30 Oct 2019 11:04:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "bp@alien8.de" <bp@alien8.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191030100418.GV4097@hirez.programming.kicks-ass.net>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <20191028135521.GB4097@hirez.programming.kicks-ass.net>
 <0a35765f7412937c1775daa05177b20113760aee.camel@intel.com>
 <20191028210052.GM4643@worktop.programming.kicks-ass.net>
 <69c57f7fa9a1be145827673b37beff155a3adc3c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c57f7fa9a1be145827673b37beff155a3adc3c.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 05:27:43PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2019-10-28 at 22:00 +0100, Peter Zijlstra wrote:

> > That should be limited to the module range. Random data maps could
> > shatter the world.
> 
> BPF has one vmalloc space allocation for the byte code and one for the module
> space allocation for the JIT. Both get RO also set on the direct map alias of
> the pages, and reset RW when freed.

Argh, I didn't know they mapped the bytecode RO; why does it do that? It
can throw out the bytecode once it's JIT'ed.

> You mean shatter performance?

Shatter (all) large pages.
