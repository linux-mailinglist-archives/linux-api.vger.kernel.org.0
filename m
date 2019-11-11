Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114F8F7751
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 16:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKKPDW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 10:03:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726832AbfKKPDW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 10:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573484601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lyJlehl3SHL3cILoyZTYkZm+/0A3k7QAa57z5CMFPs=;
        b=Vu/oh9dAeUg5JErcUHh+zH3gfdKbqqGMNVyz6Egj9BKQi36uB+qxhvV8x60EgOyvmux0p8
        /aMJqdadavHG6QAYxCKLVCD5VwwhBDIaL6s4U3tHmsu/c69MvgMhOpFH86BxEMZLEboLoj
        iO/4QuHHjU7cvYIhpcYuPapzESEflN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-oVSFwkg6M_O6eCXYgu36-g-1; Mon, 11 Nov 2019 10:03:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65813800C61;
        Mon, 11 Nov 2019 15:03:18 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 493CB52F3;
        Mon, 11 Nov 2019 15:03:13 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: For review: documentation of clone3() system call
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
Date:   Mon, 11 Nov 2019 16:03:11 +0100
In-Reply-To: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
        (Michael Kerrisk's message of "Fri, 25 Oct 2019 18:59:31 +0200")
Message-ID: <87tv7awj4g.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: oVSFwkg6M_O6eCXYgu36-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Michael Kerrisk:

>        Another  difference  for  the  raw clone() system call is that the
>        stack argument may be NULL, in which case the child uses a  dupli=
=E2=80=90
>        cate  of the parent's stack.  (Copy-on-write semantics ensure that
>        the child gets separate copies of stack pages when either  process
>        modifies  the  stack.)   In  this case, for correct operation, the
>        CLONE_VM option should not be specified.  (If the child shares the
>        parent's  memory  because of the use of the CLONE_VM flag, then no
>        copy-on-write duplication occurs and chaos is likely to result.)

I think sharing the stack also works with CLONE_VFORK with CLONE_VM, as
long as measures are taken to preserve the return address in a register.

Thanks,
Florian

