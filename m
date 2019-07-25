Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A6742A2
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 02:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbfGYAoZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 20:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387421AbfGYAoZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 24 Jul 2019 20:44:25 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251A921901;
        Thu, 25 Jul 2019 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564015464;
        bh=BnJm16XIJ4U5h0/wFfNFjUiyQUQlm05rCuTqzXG01x0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DTMevEAy6MsZBxplreEMB+bJxmKA1GsWpZtLmWP6cVbMq2QKKqVCfOMcytQ8gUcHi
         2JRtFP16ImDGp/MasraDgzI0X9ruqK1X25hWfedDjzH+kLP0i3V4/xHmTmNp9rmAY5
         OHff/q50Keh8KHkK1MMdNgOMrgVrKIzoTZZ1Fr0Y=
Date:   Wed, 24 Jul 2019 17:44:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@kernel.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [v4 PATCH 2/2] mm: mempolicy: handle vma with unmovable pages
 mapped correctly in mbind
Message-Id: <20190724174423.1826c92f72ce9c815ebc72d9@linux-foundation.org>
In-Reply-To: <6aeca7cf-d9da-95cc-e6dc-a10c2978c523@suse.cz>
References: <1563556862-54056-1-git-send-email-yang.shi@linux.alibaba.com>
        <1563556862-54056-3-git-send-email-yang.shi@linux.alibaba.com>
        <6c948a96-7af1-c0d2-b3df-5fe613284d4f@suse.cz>
        <20190722180231.b7abbe8bdb046d725bdd9e6b@linux-foundation.org>
        <a9b8cae7-4bca-3c98-99f9-6b92de7e5909@linux.alibaba.com>
        <6aeca7cf-d9da-95cc-e6dc-a10c2978c523@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 24 Jul 2019 10:19:34 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 7/23/19 7:35 AM, Yang Shi wrote:
> > 
> > 
> > On 7/22/19 6:02 PM, Andrew Morton wrote:
> >> On Mon, 22 Jul 2019 09:25:09 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >>>> since there may be pages off LRU temporarily.  We should migrate other
> >>>> pages if MPOL_MF_MOVE* is specified.  Set has_unmovable flag if some
> >>>> paged could not be not moved, then return -EIO for mbind() eventually.
> >>>>
> >>>> With this change the above test would return -EIO as expected.
> >>>>
> >>>> Cc: Vlastimil Babka <vbabka@suse.cz>
> >>>> Cc: Michal Hocko <mhocko@suse.com>
> >>>> Cc: Mel Gorman <mgorman@techsingularity.net>
> >>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> >>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >> Thanks.
> >>
> >> I'm a bit surprised that this doesn't have a cc:stable.  Did we
> >> consider that?
> > 
> > The VM_BUG just happens on 4.9, and it is enabled only by CONFIG_VM. For 
> > post-4.9 kernel, this fixes the semantics of mbind which should be not a 
> > regression IMHO.
> 
> 4.9 is a LTS kernel, so perhaps worth trying?
> 

OK, I'll add cc:stable to 

mm-mempolicy-make-the-behavior-consistent-when-mpol_mf_move-and-mpol_mf_strict-were-specified.patch

and

mm-mempolicy-handle-vma-with-unmovable-pages-mapped-correctly-in-mbind.patch

Do we have a Fixes: for these patches?
