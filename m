Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79E0160C09
	for <lists+linux-api@lfdr.de>; Mon, 17 Feb 2020 08:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgBQH7o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Feb 2020 02:59:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgBQH7o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Feb 2020 02:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u+qbunCLoImJlKPf9M1OUAgIIN//AvIrEPu2le+1et4=; b=pyZzDjG5VaY1EeVrlxpSbjyZtU
        Oc+ORmiYlpXPZYKPNwgtE3N70SZArwV4dNwu/uyRhr5D7d1nd+M/oAwUFpNi82iEKtGutr1Yq0DfS
        vlnRayUCiWp68ayBF2HYwfFpAl6jB6gtVQ9gsOdDxt36/kCngrQwHRluzHHR/a3ejAp8dQY4it7eH
        MYVZBrSo1YJGU0Mp42zhYMZ0psyRuXBuLF+fV2QcWPxV0mVIHpIFFT9rEdZs/J95YzGXZJdc48GBR
        Md+sIfXEEFbBJ/WzjIPd3Hg7PXWxRsVaDOcbYmPrkaFixt0iwmUba7PiJqk8BHAJVHPqqhutiyydc
        /ayUKuaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3bJc-0002xV-MM; Mon, 17 Feb 2020 07:59:40 +0000
Date:   Sun, 16 Feb 2020 23:59:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v5 4/7] pid: export pidfd_get_pid
Message-ID: <20200217075940.GA10342@infradead.org>
References: <20200214170520.160271-1-minchan@kernel.org>
 <20200214170520.160271-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214170520.160271-5-minchan@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 14, 2020 at 09:05:17AM -0800, Minchan Kim wrote:
> process_madvise syscall needs pidfd_get_pid function to translate
> pidfd to pid so this patch exports the function.

For that it should not need to exported, but then again the actual
patch doesn't export it anyway, so this is just a commit log issue.

>  extern struct pid *pidfd_pid(const struct file *file);
> +extern struct pid *pidfd_get_pid(unsigned int fd);

... and there is no need for the extern keyword on prototypes in
headers.
