Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3A177855
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2020 15:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgCCOJY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Mar 2020 09:09:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727913AbgCCOJY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Mar 2020 09:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583244563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1oQbBmvrBGg0OPWPnhd5xlRIiyvJNmigaWzMX+f8Oo=;
        b=Hk6M5h8no4DBgLFBrEq9Z1+PdfBBGrQzf0x4pc1IDWMOYvwgSZGit7toOz95vkfsA6IKTu
        nx9t1dW09QxHg4w7WEQGuyWoOx9mzN8yjkXH0uSq3x0Gr+yl3Jjm5fZNGOXHW2J0fjfsva
        HwCsxKaA9arK+8AHiGjv9CyFAe8fSfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-V0i0Dt2SOYSUsHpCEce_5g-1; Tue, 03 Mar 2020 09:09:19 -0500
X-MC-Unique: V0i0Dt2SOYSUsHpCEce_5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995FA18B9FC1;
        Tue,  3 Mar 2020 14:09:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A16BA60BE1;
        Tue,  3 Mar 2020 14:09:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200303130347.GA2302029@kroah.com>
References: <20200303130347.GA2302029@kroah.com> <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com> <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk> <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com> <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net> <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com> <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com> <20200303113814.rsqhljkch6tgorpu@ws.net.home>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1656812.1583244553.1@warthog.procyon.org.uk>
Date:   Tue, 03 Mar 2020 14:09:13 +0000
Message-ID: <1656813.1583244553@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Actually, I like this idea (the syscall,

It might mesh well with atomic_open in some way.

David

