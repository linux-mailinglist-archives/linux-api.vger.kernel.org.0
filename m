Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA53121BBE3
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2020 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGJRJC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jul 2020 13:09:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48389 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727990AbgGJRJB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jul 2020 13:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594400940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dIJ9Cu+pL+yyFjMqrEiFKXlTlYcC1jnm87VZK4JkkJ0=;
        b=bvaVOM+pbgMBPIZ7y/nl0Z7t5nYGBGiGwx8oJZH6IK3KtUXRBnDpTPlTp0AjjF5RHsVTgQ
        x9MdPW/Rcx1juwLz0MpyHxHkgIJtNEXLEowZYt0nrRK2fpJbBqggW56lg7KD8lWCtI3lIf
        lZXwB5lMHoY9hCTMwcvFzIVMICwjsbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-yemVJvaxOsOSsDOYurKUgw-1; Fri, 10 Jul 2020 13:08:56 -0400
X-MC-Unique: yemVJvaxOsOSsDOYurKUgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F72A800FF1;
        Fri, 10 Jul 2020 17:08:54 +0000 (UTC)
Received: from mail (ovpn-112-112.rdu2.redhat.com [10.10.112.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E437A6FEC3;
        Fri, 10 Jul 2020 17:08:53 +0000 (UTC)
Date:   Fri, 10 Jul 2020 13:08:53 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/5] mm: make HPAGE_PxD_{SHIFT,MASK,SIZE} always
 available
Message-ID: <20200710170853.GB11749@redhat.com>
References: <20200706172051.19465-1-rppt@kernel.org>
 <20200706172051.19465-2-rppt@kernel.org>
 <alpine.LSU.2.11.2007062153000.2793@eggly.anvils>
 <20200710164037.GA11749@redhat.com>
 <20200710165746.GO12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710165746.GO12769@casper.infradead.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 10, 2020 at 05:57:46PM +0100, Matthew Wilcox wrote:
> btw, using the hpage_ prefix already caused one problem in the hugetlb
> code:
> 
> https://lore.kernel.org/linux-mm/20200629185003.97202-1-mike.kravetz@oracle.com/
> 
> I'd suggest we rename these to THP_PMD_* and THP_PUD_* to make it clear
> they're only for the THP case.

The confusion seem to have happened only about hpage_nr_pages not
about HPAGE_PMD_*. It's just the hpage_ prefix alone that is commonly
used by hugetlbfs only and so it's not surprising it caused confusion.

So I certainly agree hpage_nr_pages would better be renamed to
something more THP specific (either hpage_pmd_nr_pages or
trans_huge_nr_pages or as you wish), but HPAGE_PMD_ don't look too
confusing about the fact it's only for the THP case since the non-THP
case won't necessarily care about PMDs.

Thanks,
Andrea

