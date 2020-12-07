Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5CE2D18C6
	for <lists+linux-api@lfdr.de>; Mon,  7 Dec 2020 19:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgLGSwh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Dec 2020 13:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgLGSwh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Dec 2020 13:52:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F7C061793
        for <linux-api@vger.kernel.org>; Mon,  7 Dec 2020 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=lwRy1gpudVVoWmouXuPLhNR7OGbUNao9gVEhieWRiRs=; b=QpRtc/LqTk+DSHwDkHD6PyMWDo
        N2tiuD9HOKDLGI5iHmPJTX0SK8poNg/ssxDi1dHnd4C6sUx2kU8SOCZb2b+pSQH1osSwNncPtc1bR
        YeXjdgmntTuPbV59ZY5uxKdL16yu8FbhFJRUo8r7lhHW9lxk2yYVbsDvhs3m8pEHtXG7n0x0SNG79
        Nju218ww+d+dzpaYaw8NuH/aeBdFuvzWNRkf0FQAQk0+zvf6UaaIPddx9oz9dXkvAXqicZyX7gu8X
        r/QtNSQst1eJuG/7CdRQm3Qhy0lh3z8E+cHDqtX+Z3nY3ffzArPGMNrDDXXrmgZbcUOIGuzCpXPFj
        dn9TOT3g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmLby-0002LN-Bj; Mon, 07 Dec 2020 18:51:50 +0000
Date:   Mon, 7 Dec 2020 18:51:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, rao.shoaib@oracle.com,
        Christoph Hellwig <hch@lst.de>,
        Paolo Abeni <pabeni@redhat.com>, jbi.octave@gmail.com,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC net-next af_unix v1 0/1] Allow delivery of SIGURG on
 AF_UNIX streams socket
Message-ID: <20201207185150.GA7338@casper.infradead.org>
References: <20201207163520.GA7494@casper.infradead.org>
 <8A94EE38-C4F4-4EBE-9737-D331AD34274A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8A94EE38-C4F4-4EBE-9737-D331AD34274A@amacapital.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Dec 07, 2020 at 09:00:12AM -0800, Andy Lutomirski wrote:
> >> I'm also a bit nervous that there might be some program out there that
> >> expects SIGIO but not SIGURG on unix sockets, and you're breaking
> >> them.
> > 
> > The only incompatible scenario I've been able to think of is an
> > application which has both TCP and Unix sockets will suddenly get its
> > SIGURG handler called for Unix sockets when it's only expecting to get
> > it called for TCP sockets.  That feels like a very unlikely scenario.
> 
> So maybe this is okay. It does seem like a hack, but maybe it’s a hack that’s not too bad to support in the kernel.

I see it as extending a (somewhat bogus) TCP socket API to Unix sockets.
The mechanism is badly named.  If it were called MSG_URG instead of
MSG_OOB, I think it'd be a lot less objectionable.  Apparently the
sockets people were enamoured with the idea of having multiple streams
of data inside a single socket, which is madness.

I'd really like a way to generate SIGURG on pipes too, but that's harder
to wire up.
