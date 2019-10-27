Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F46E6209
	for <lists+linux-api@lfdr.de>; Sun, 27 Oct 2019 11:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJ0Ka2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 27 Oct 2019 06:30:28 -0400
Received: from albireo.enyo.de ([37.24.231.21]:50102 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfJ0Ka1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 27 Oct 2019 06:30:27 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iOfoT-0004Rc-RC; Sun, 27 Oct 2019 10:30:21 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iOfoT-00038w-IP; Sun, 27 Oct 2019 11:30:21 +0100
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
Date:   Sun, 27 Oct 2019 11:30:21 +0100
In-Reply-To: <1572171452-7958-1-git-send-email-rppt@kernel.org> (Mike
        Rapoport's message of "Sun, 27 Oct 2019 12:17:31 +0200")
Message-ID: <87d0eieb0i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mike Rapoport:

> The patch below aims to allow applications to create mappins that have
> pages visible only to the owning process. Such mappings could be used to
> store secrets so that these secrets are not visible neither to other
> processes nor to the kernel.

How is this expected to interact with CRIU?

> I've only tested the basic functionality, the changes should be verified
> against THP/migration/compaction. Yet, I'd appreciate early feedback.

What are the expected semantics for VM migration?  Should it fail?
