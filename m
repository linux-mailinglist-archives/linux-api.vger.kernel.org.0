Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB29168487
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBURLm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Feb 2020 12:11:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24941 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727020AbgBURLi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Feb 2020 12:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582305097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oey+jiBKGtn4SGos1yizbcranLQ5vYUebcQ+ncI0qRE=;
        b=LKDxhjnJZ3j+js7Vz5QQ+Wdc2noWDtkTY/88hyMbux2IkbjCF9Gf4OorO7l53PvH9qgGdU
        jcj7KYlbh2Xv/2C968rnFSLeze037E64cE0w6nGxwZK92EhXVZapHiExDOYhxcv3qrmwjT
        HV/3cN9OFflVU6b0tCdRQfmfHJFQ9p0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-jvkJ_iX-OzyYb5WiRMdggg-1; Fri, 21 Feb 2020 12:11:35 -0500
X-MC-Unique: jvkJ_iX-OzyYb5WiRMdggg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2EEF8017CC;
        Fri, 21 Feb 2020 17:11:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10D3A8ECFD;
        Fri, 21 Feb 2020 17:11:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2vzgVgJw7-WKa1GbyLw2nJGvAnS21w=gHV02rUNheYFw@mail.gmail.com>
References: <CAG48ez2vzgVgJw7-WKa1GbyLw2nJGvAnS21w=gHV02rUNheYFw@mail.gmail.com> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204561120.3299825.5242636508455859327.stgit@warthog.procyon.org.uk> <CAG48ez2B2J_3-+EjR20ukRu3noPnAccZsOTaea0jtKK4=+bkhQ@mail.gmail.com> <1897788.1582295034@warthog.procyon.org.uk> <CAG48ez2nFks+yN1Kp4TZisso+rjvv_4UW0FTo8iFUd4Qyq1qDw@mail.gmail.com> <2031798.1582302800@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/19] vfs: Add superblock notifications [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2125808.1582305091.1@warthog.procyon.org.uk>
Date:   Fri, 21 Feb 2020 17:11:31 +0000
Message-ID: <2125809.1582305091@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> If another thread concurrently runs close(watch_fd)

Fair point.  We have the watch queue pinned, but watch_queue_clear() is called
before the ref is released.

David

