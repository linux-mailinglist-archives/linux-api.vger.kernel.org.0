Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1C933A3D2
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 10:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhCNJQF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Mar 2021 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhCNJP7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Mar 2021 05:15:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E2AC061574;
        Sun, 14 Mar 2021 01:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TWvz+uUE9a8YWLli6MgkhitIFLF6au76H0ezmr1npJk=; b=Lprx96r9Np8HbSg8L5S4AMBWtG
        jIiZN9+w3VTnRd7NrppfxjEuT7d4ADdg6sKsGNORq59Kvey6j5GIkDJPiNBsyc9gs+6B+tQX1w7Cl
        l6fqa+gvvRJ3SYay50wLGDKA1tp16eqNOHF/7x4I0wgsEIIBkPv1A5bcR9nCSV/UskeRkLEt3n172
        V7k2JYe13FwzqP+8gY7bNx6ajhG/8M5jnqKuk/2wFU+UOf/KnPdwdmGaVy7J4NDvJvefStwdy4b3B
        zY56/bHFCyQKgLWiecDv9ePFDnOEf2teKljAQ1vnn8EOzkxgRZOie+7WJOmqlHj/FpFdb/KVSWFKu
        +tuwHmwg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLMpd-00Fpf6-5r; Sun, 14 Mar 2021 09:14:55 +0000
Date:   Sun, 14 Mar 2021 09:14:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        pavel.tide@veeam.com
Subject: Re: [PATCH v7 1/3] block: add blk_mq_is_queue_frozen()
Message-ID: <20210314091441.GA3773360@infradead.org>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-2-git-send-email-sergei.shtepa@veeam.com>
 <20210312190641.GA2550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312190641.GA2550@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 12, 2021 at 02:06:41PM -0500, Mike Snitzer wrote:
> This is returning a frozen state that is immediately stale.  I don't
> think any code calling this is providing the guarantees you think it
> does due to the racey nature of this state once the mutex is dropped.

The code only uses it for asserts in the form of WARN_ONs.
