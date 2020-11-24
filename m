Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42332C2835
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 14:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbgKXNhW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 08:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgKXNhV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 08:37:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915BFC0613D6;
        Tue, 24 Nov 2020 05:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gxsDeVGamS0hlIf6ve+2luB3JdMIOEqdPuqPaIv9Dls=; b=VBYUp/uEnseBoeTeKEhlEWh3HQ
        g9jh5J/6w+XXN7KTPAWqRI2umbF+U2cvDEHRZ2+NADxjtfotGOawPf+w3FZ95YmoiYfvSAmBJq9D4
        26wEASipBY6rGNiLU2Hi8AssdKYuF70q8nnjB8RjiU2SZP0YZgXvYmtZelAahPgqFm4LGeIQPwHt2
        lo8QqqROqwzFUNAoeIMBekulW9J+J1XJwzu6vYqp6gvntJCCRyHMb2MlYx3Ct96pZ8dB9NbUflhGt
        pjlmHxstjZln9ZulPC9kuS4AQj7iF7mj/kiKWYtjSCVN0VIYtEoRfye1lyQIHousEOYYA4BSj7/yO
        m9EVCaBg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYVT-00086n-HE; Tue, 24 Nov 2020 13:37:19 +0000
Date:   Tue, 24 Nov 2020 13:37:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
Message-ID: <20201124133719.GA30896@infradead.org>
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 01:08:20PM +0100, Florian Weimer wrote:
> This documents a way to safely use new security-related system calls
> while preserving compatibility with container runtimes that require
> insecure emulation (because they filter the system call by default).
> Admittedly, it is somewhat hackish, but it can be implemented by
> userspace today, for existing system calls such as faccessat2,
> without kernel or container runtime changes.

I think this is completely insane.  Tell the OCI folks to fix their
completely broken specification instead.
