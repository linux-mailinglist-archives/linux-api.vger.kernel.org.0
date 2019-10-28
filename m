Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFECE7AAC
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 22:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfJ1VBG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 17:01:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbfJ1VBG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Oct 2019 17:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6ftG5m8lGvtedzGNIH5EOrt+Fv7RjR731OYTUpDU54Q=; b=OS1tUSpLYQrfvH2uh3T8yVlGK
        T7vhvhCzh7nVRAzZliu0ZIg07uS6OEiYQnOoOi85JBZI0iWrON0Iu16vQgduHVD22bRenrk9MGAdp
        uKcnafOMm1FrL5HAuNXYEsXhlIcGEMrU6hR88iugETvhQ56ZTauoT25wIC/CX7I6yOScFSL3u9p9Z
        3gL380MjV/ekE7yewMAuJQ+LNROKsn39Kf6t6EgN74581tf3VaAZEpON5BrcWyixhoW+HO6jGlt9M
        YJgIJdVSxS68w5NheNlkd85yKwG1pk0hkWD4CtwgdW8e6ITdTg+yLNLjf7GTnYPILEHpJcwu0B0O/
        n94zFzRaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPC84-0005Ll-7y; Mon, 28 Oct 2019 21:00:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED6FD980D8F; Mon, 28 Oct 2019 22:00:52 +0100 (CET)
Date:   Mon, 28 Oct 2019 22:00:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "kirill@shutemov.name" <kirill@shutemov.name>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
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
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191028210052.GM4643@worktop.programming.kicks-ass.net>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <20191028135521.GB4097@hirez.programming.kicks-ass.net>
 <0a35765f7412937c1775daa05177b20113760aee.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a35765f7412937c1775daa05177b20113760aee.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 07:59:25PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2019-10-28 at 14:55 +0100, Peter Zijlstra wrote:
> > On Mon, Oct 28, 2019 at 04:16:23PM +0300, Kirill A. Shutemov wrote:
> > 
> > > I think active use of this feature will lead to performance degradation of
> > > the system with time.
> > > 
> > > Setting a single 4k page non-present in the direct mapping will require
> > > splitting 2M or 1G page we usually map direct mapping with. And it's one
> > > way road. We don't have any mechanism to map the memory with huge page
> > > again after the application has freed the page.
> > 
> > Right, we recently had a 'bug' where ftrace triggered something like
> > this and facebook ran into it as a performance regression. So yes, this
> > is a real concern.
> 
> Don't e/cBPF filters also break the direct map down to 4k pages when calling
> set_memory_ro() on the filter for 64 bit x86 and arm?
> 
> I've been wondering if the page allocator should make some effort to find a
> broken down page for anything that can be known will have direct map permissions
> changed (or if it already groups them somehow). But also, why any potential
> slowdown of 4k pages on the direct map hasn't been noticed for apps that do a
> lot of insertions and removals of BPF filters, if this is indeed the case.

That should be limited to the module range. Random data maps could
shatter the world.
