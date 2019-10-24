Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DBCE3736
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2019 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503400AbfJXPy6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Oct 2019 11:54:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503393AbfJXPy5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Oct 2019 11:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571932496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2ExiigEByCtsmRRvNsGaGfhM9mM9F5zlr4YhPOUDug=;
        b=Slhwk2iVkogSau2UovSoFzTFDf8kgcKFe2LUv/K41U/tRIYekv/IZrhEgLwINFL1mD14yc
        Uy2QdBHLm3vqFWsU+L2vfmuYarNV2CmSKFHwUtLEZzn0VzG3QUCx50rep1/RwXiu2YhQQ9
        JlWZcMPU/YmcwbDO0COLhph1QDQ5O+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-gGkffQx-MgiQBUn_hUtQng-1; Thu, 24 Oct 2019 11:54:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A6E885EE90;
        Thu, 24 Oct 2019 15:10:55 +0000 (UTC)
Received: from mail (ovpn-123-192.rdu2.redhat.com [10.10.123.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25B35196B2;
        Thu, 24 Oct 2019 15:10:55 +0000 (UTC)
Date:   Thu, 24 Oct 2019 11:10:54 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
Message-ID: <20191024151054.GJ9902@redhat.com>
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
 <20191023190959.GA9902@redhat.com>
 <20191024090258.GA9802@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191024090258.GA9802@linux.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gGkffQx-MgiQBUn_hUtQng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

On Thu, Oct 24, 2019 at 12:02:59PM +0300, Mike Rapoport wrote:
> That's no the reason that UFFD_FEATURE_EVENT_FORK does not show up in
> Debian code search, CRIU simply is not there. Debian packages CRIU only i=
n
> experimental and I believe that's not indexed by the code search.
>=20
> As for the limitations, the races were fixed, I just forgot to update the
> wiki. As for the supported memory types and COW pages, these only affect
> efficiency of post-copy, but not the correctness.

That's what I was hoping for. If the wiki information is stale and
there are no races it is totally plausible that it's being actively
used in production so we need to fix the kernel bug. I was just
checking because I wasn't sure anymore of the status after I read the
wiki.

If the CRIU initialization code that issues the uffd syscall runs as
global root the ABI breaking permission check from Andy sounds the
simplest for a short term fix, because it will be unnoticed by any
production usage with CIRU --lazy-pages.

Then later we could add a UFFD_FEATURE_EVENT_FORK2 that will not
require root permission.

Thanks,
Andrea

