Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E93E8AE5
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 15:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbfJ2Ogx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 10:36:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389024AbfJ2Ogx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 10:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572359812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyppzqRGiPy9BVmoF02ZpY6VIa9FjG7DXct9lAL3RIs=;
        b=Uf3bbRQxaeB6gyBifgBBC3u7nziuhU8lWSOrldaD5bFpNFFnO1qwROEm7HURkpp8Sldou3
        F/iALr9PGnUfbqfu29QJv00ipkS/DbvXP1Ffl2Z12FeB+XCbAaAP0cCuhfn+lMKOzWkPHC
        t93kqmKxzG3nL8Rs6o1PRbjGfpe2SwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-YgVaSQgANh2_4z7kLFV9CA-1; Tue, 29 Oct 2019 10:36:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CD8381A334;
        Tue, 29 Oct 2019 14:36:46 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73EBB2635C;
        Tue, 29 Oct 2019 14:36:39 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jann Horn <jannh@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: For review: documentation of clone3() system call
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
        <CAG48ez3q=BeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0neheT17TA@mail.gmail.com>
        <20191028172143.4vnnjpdljfnexaq5@wittgenstein>
        <CAG48ez20hn8vToY+=C62nA-rbUfxh=JD6N-f7XVS3_GZOoPjxw@mail.gmail.com>
        <20191029112706.p5dd5yzpcgouo6n5@wittgenstein>
        <20191029142622.jxmssu4s4ndui7bw@wittgenstein>
Date:   Tue, 29 Oct 2019 15:36:37 +0100
In-Reply-To: <20191029142622.jxmssu4s4ndui7bw@wittgenstein> (Christian
        Brauner's message of "Tue, 29 Oct 2019 15:26:23 +0100")
Message-ID: <87wocn39fu.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YgVaSQgANh2_4z7kLFV9CA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christian Brauner:

> @Florian, do you have an opinion about always passing the stack from the
> lowest address with clone3()?

Do you mean that the stack extends from stack to stack_size?  I guess
that makes sense.  What about architectures which need two stacks (I
think ia64 is one)?

There is also the matter whose responsibility is the alignment of the
initial stack pointer.

Thanks,
Florian

