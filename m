Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5320F2C2D41
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbgKXQrC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 11:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390499AbgKXQrC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 11:47:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF6C0613D6;
        Tue, 24 Nov 2020 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OeFcB57Hzme+McA149faAASH3YWyNoWzSrZKHO+M9wg=; b=jfj3/WckeE0gt5QsNRl1XyUXh1
        ik9cC6kiwu+vWl1prkmCida1cXfWA68odX3iq+voHU5T0ezXtvxIfUeZWu0DIES2zwOdgTfX0S+nW
        t6XXdl0VXeF4UEfFk/qgzp1tr0X6eEwzjYFFLxJuFv7HTeXysaKWpvDmg2qSwXS4F+10P2skpGVY/
        QhXVPgcouXlF8na/wGZYO9fw3DKCtgCNS29w7SGaEcUaePN81OZVlSj8yUI+Gq5wHF4N7RtzsevZ7
        4EXO5GimzNVi2kaoxh3qP4MzZlEOijBfVZVTW6Dx2O4AKs79L6yVuPCZuPLy0P6oOWovfyAke1zVc
        FHDmVN3A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khbT1-0003pf-Bq; Tue, 24 Nov 2020 16:46:59 +0000
Date:   Tue, 24 Nov 2020 16:46:59 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dev@opencontainers.org, corbet@lwn.net,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
Message-ID: <20201124164659.GB14094@infradead.org>
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
 <20201124133719.GA30896@infradead.org>
 <87k0ua26gm.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ua26gm.fsf@oldenburg2.str.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 03:08:09PM +0100, Florian Weimer wrote:
> Do you categorically reject the general advice, or specific instances as
> well?

All of the above.  Really, if people decided to use seccompt to return
nonsensical error codes we should not work around that in new kernel
ABIs.
