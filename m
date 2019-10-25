Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92EAE45CF
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2019 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404439AbfJYIfP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Oct 2019 04:35:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404589AbfJYIfL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Oct 2019 04:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571992510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gsc+0cnWp+SeXo5Ab/Z5m/x0oLsQUzNBoPuLzeohPH8=;
        b=NOPUEBQcEdYBmqATxtXkRECvwvwTFH+9JO5ZYGM6BHmE/mluTOZi+2GQUBQyru2lR6UaZ4
        1iYY5FOhu12pgVbavx/TQkfDfBV9WRRAe37Mf0+MJSFznfgbKUMPSOo0gbGPEnZC7mPyq3
        dUL/Jzb7wLq4cjMVOw5lX8zi5Dp5tlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-Yt-flKkyMo6CKNT7t3AOmw-1; Fri, 25 Oct 2019 04:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5E9E800D41;
        Fri, 25 Oct 2019 08:35:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFDF84100;
        Fri, 25 Oct 2019 08:35:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
References: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <30394.1571936252@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
MIME-Version: 1.0
Content-ID: <9190.1571992499.1@warthog.procyon.org.uk>
Date:   Fri, 25 Oct 2019 09:34:59 +0100
Message-ID: <9191.1571992499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Yt-flKkyMo6CKNT7t3AOmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > The keyrings testsuite needs the ability to wait for all the outstandin=
g
> > notifications in the queue to have been processed so that it can then g=
o
> > through them to find out whether the notifications it expected have bee=
n
> > emitted.
>=20
> Can't you just do
>=20
>     ioctl(fd, FIONREAD, &count);
>=20
> in a loop instead? "No paperwork. Just sprinkle some msleep() crack on
> him, and let's get out of here"

Using FIONREAD like this means that I would have to quiesce the tests in or=
der
to sync up.  For the moment that's fine, but at some point I would like to =
be
able to stress test the system by running tests in parallel against the sam=
e
keyring.  Each test needs to check with the monitor whether its keys have
generated the appropriate notifications against a backdrop of events being
continuously generated by other tests.

I can hold this patch for now.  Let me see if I can come up with a better w=
ay
to do it.  Maybe it can be done by dead reckoning, holding up until either
we've counted out a complete ring-full of notifications or read() has come =
up
empty.

David

