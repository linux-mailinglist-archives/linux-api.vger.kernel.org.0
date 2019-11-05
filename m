Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAFFF0383
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKEQ5I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 11:57:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34165 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730821AbfKEQ5I (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 11:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572973027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/CYal2Ht1Wk+CkyE9G0+kWfB1JTDB8P2q0I4iMUmUk=;
        b=ARteMhcUalj62/0PtHhYUU+Jz5mzk9A/Rocx7HNKUukVeEL9D60O6jX68JUWScMYpVUNtD
        kvnRUQjrQ3Dz9Am1jkdf6YCdbW8eJRGnDYXoA34KqaoD8x5766jAz5u/Z3sqdKR5T3+EDe
        mD0rBeI12liJIqwEN/44Jj79iAcghW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-fND83D8KND2PRYRlMZm3mw-1; Tue, 05 Nov 2019 11:55:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4106107ACC3;
        Tue,  5 Nov 2019 16:55:57 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AAD827065;
        Tue,  5 Nov 2019 16:55:57 +0000 (UTC)
Date:   Tue, 5 Nov 2019 11:55:56 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for
 UFFD_FEATURE_EVENT_FORK
Message-ID: <20191105165556.GK30717@redhat.com>
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
 <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <CAKOZuetu0QWUDAycTOFzC4HEbjH99EtOhb4gJnHAuovT_StpzA@mail.gmail.com>
 <20191105163316.GI30717@redhat.com>
 <CAKOZuet1Hrdd7U4VVBmXNCkE6xwiUPERRHjP=A3bX6B9A4BQRQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKOZuet1Hrdd7U4VVBmXNCkE6xwiUPERRHjP=A3bX6B9A4BQRQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: fND83D8KND2PRYRlMZm3mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 05, 2019 at 08:39:26AM -0800, Daniel Colascione wrote:
> I'm not suggesting that we fail userfaultfd(2) without CAP_SYS_PTRACE.
> That would, as you point out, break things. I'm talking about
> recording *whether* we had CAP_SYS_PTRACE in an internal flag in the
> uffd context when we create the thing --- and then, at ioctl time,
> checking that flag, not the caller's CAP_SYS_PTRACE, to see whether
> UFFD_FEATURE_EVENT_FORK should be made available. This way, the
> security check hinges on whether the caller *at create time* was
> privileged.

Until now it wasn't clear to me you still wanted to do the permission
check in UFFDIO_API time, and you only intended to move the
"measurement" of the capability to the syscall.

So you're suggesting to add more kernel complexity to code pending for
removal to achieve a theoretically more pure solution in the band-aid
required to defer the removal of the posix-breaking read
implementation of the uffd fork feature?

