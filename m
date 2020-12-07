Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B645B2D1670
	for <lists+linux-api@lfdr.de>; Mon,  7 Dec 2020 17:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgLGQgM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Dec 2020 11:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgLGQgM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Dec 2020 11:36:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED0C061749
        for <linux-api@vger.kernel.org>; Mon,  7 Dec 2020 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TS4GPjURoMTP1r0HD0o3RnIROPRYxUqaJN0s6y7Uw88=; b=VBJjngNYZqfmb+Ytxu7XHcy3Iw
        cEVSoWswF2ma+bFzUM0npQBCtLSFtZqUdlcXNxwLpBETS3HAdlXosFLW6B0VYvAHIyaJTfjuUiCYe
        h0Op6dnZNdKL6CS2lrgGi0Q2hHusqyGkG9EsvfsM0bS/Zp3EDj2N36oEH4R8f0BT60hzl2+jFlxPt
        UUKbBbqZHGL0XKxE2NxUw94m42Jn7jvFWuvPPJL+nuhXUepTZLbx8FXkOOQBwHJHIDokPMi+3D5wj
        RJsTN62ZkgpJomVOY6o0y402lTKhfCqOLjprRlB0kTWfhcBScg4ZBoLT22bDGl4cTyAigfCJ0Quqm
        9/QmTcbA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmJTs-0002Wp-6A; Mon, 07 Dec 2020 16:35:20 +0000
Date:   Mon, 7 Dec 2020 16:35:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     rao.shoaib@oracle.com, Christoph Hellwig <hch@lst.de>,
        Paolo Abeni <pabeni@redhat.com>, jbi.octave@gmail.com,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC net-next af_unix v1 0/1] Allow delivery of SIGURG on
 AF_UNIX streams socket
Message-ID: <20201207163520.GA7494@casper.infradead.org>
References: <1606618332-23345-1-git-send-email-rao.shoaib@oracle.com>
 <CALCETrUKuzwU=xiDq8Kk8H-bE1R6K-pN5ZhCFWH9bxR+_Z=NwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUKuzwU=xiDq8Kk8H-bE1R6K-pN5ZhCFWH9bxR+_Z=NwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 28, 2020 at 08:02:37PM -0800, Andy Lutomirski wrote:
> On Sat, Nov 28, 2020 at 7:07 PM <rao.shoaib@oracle.com> wrote:
> > We have a use case where thousands of processes connect locally to a
> > database and issue queries that are serviced by a pool of threads.
> > Communication is done over AF_UNIX sockets. Currently, there is no way
> > for the submitter to signal the servicing thread about an urgent
> > condition such as abandoning the query.
> 
> Sure there is.  You could close() the socket.  You could send() a
> message saying that your query wants to be canceled.  You could use a
> second socket for this if it's somehow inconvenient to do it with a
> single socket.

The application already works with SIGURG (and TCP, obviously).  Yes,
it could be changed to use one of these other methods, but they're all
more inconvenient to use than SIGURG.

> > This patch addresses that
> > requirement by adding support for MSG_OOB flag for AF_UNIX sockets.
> > On receipt of such a flag, the kernel sends a SIGURG to the peer.
> 
> SIGURG is a horrible interface.  It doesn't scale -- signals are slow,
> and they give no indication of *which* socket has urgent data.

It doesn't need to scale.  This is "client wishes to abort the operation",
just like telnet.  Each thread only has one socket (and, thanks to
F_SETOWN_EX, signals for that socket get directed to that thread).

> Aside
> from this, the "urgent" interface itself is nuts -- even the TCP RFCs
> and implementations seem unable to agree on exactly how to tell
> *which* data is urgent.

That doesn't matter.  Unix sockets with MSG_OOB behave like they
have had SO_OOBINLINE which is the recommendation from
https://tools.ietf.org/html/rfc6093

> At least epoll might be a scalable way to
> tell which socket has urgent data, but that's not what your patch
> description seems to be talking about.

epoll is the wrong interface for this application, as far as I can tell.

> Oh yeah, SIGURG simply doesn't work across privilege boundaries.

Please elaborate.  SIGURG is default-ignore, so you have to enable a
handler for it.  And you have to call SETOWN to receive a signal.

> I'm also a bit nervous that there might be some program out there that
> expects SIGIO but not SIGURG on unix sockets, and you're breaking
> them.

The only incompatible scenario I've been able to think of is an
application which has both TCP and Unix sockets will suddenly get its
SIGURG handler called for Unix sockets when it's only expecting to get
it called for TCP sockets.  That feels like a very unlikely scenario.
