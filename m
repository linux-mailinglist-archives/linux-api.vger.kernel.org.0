Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC33E72E9
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfJ1Nzm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 09:55:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfJ1Nzm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Oct 2019 09:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GeTgSWc782B9W4ttmjLGz4tgdC/DzGai4EkjN8ttTKc=; b=mMXIKL2SEtnqYcFTQBFfETqhZ
        Tik560Qg9n6orWmQPYldLjhvMjniKjLbno+NwSEb9TYeRNIWNXJD/1bMh11f8hnaF+RgyC001i3d3
        ZJRxqy5yl68i/gCeXxlX55eHIydz4e/ikFkQdUpIaqL4bN90K2MvMKBhoOU5LDHogJz5Otc/URQfG
        7zZ08LN4Q54Wcvo9ckkTInlSlsnCYlAXUovXdCMYNAwAikOp2lUvONs7HCNQjR01nvvlltaScYM6t
        LoWnXVA4shjcPXbGcKOaCkfzLwdTR5rYN+qc/uVcQ5uLMEI9jkyEMfBdPzJILxRtEFzusVyV4+7PT
        Pb4rM4lBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP5US-00055y-Io; Mon, 28 Oct 2019 13:55:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CFBE3002B0;
        Mon, 28 Oct 2019 14:54:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86173200DCF2A; Mon, 28 Oct 2019 14:55:21 +0100 (CET)
Date:   Mon, 28 Oct 2019 14:55:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191028135521.GB4097@hirez.programming.kicks-ass.net>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028131623.zwuwguhm4v4s5imh@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 04:16:23PM +0300, Kirill A. Shutemov wrote:

> I think active use of this feature will lead to performance degradation of
> the system with time.
> 
> Setting a single 4k page non-present in the direct mapping will require
> splitting 2M or 1G page we usually map direct mapping with. And it's one
> way road. We don't have any mechanism to map the memory with huge page
> again after the application has freed the page.

Right, we recently had a 'bug' where ftrace triggered something like
this and facebook ran into it as a performance regression. So yes, this
is a real concern.
