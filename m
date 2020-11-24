Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF42C2FB7
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404171AbgKXSJz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 13:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390790AbgKXSJz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 13:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606241394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uUA8/aOgpZ26JxcYo0ZLju1cjGrlPjY1iezm4VSo/Pg=;
        b=GhWd6eITMF9ahzzmgCcELFdEbuk2UpvxGwWAxy1VPj7GkiN9MlgHtBQaNlFs0qS5YzmAcm
        RPv5NthTPuN47/pfmYBFqTmuAPx2KqhNrmgCsGOlz6jtCs0OKI27x6PXsbcIT3q7xT2+MH
        DLzLWRhLTFogtbx7yt8EfcjI3FHtFUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-QEKI0QbqNuOLThpMqBG3UA-1; Tue, 24 Nov 2020 13:09:52 -0500
X-MC-Unique: QEKI0QbqNuOLThpMqBG3UA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D3FB809DDF;
        Tue, 24 Nov 2020 18:09:51 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-141.ams2.redhat.com [10.36.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D70F5C1A3;
        Tue, 24 Nov 2020 18:09:46 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mark Wielaard <mark@klomp.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
        <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
        <878saq3ofx.fsf@oldenburg2.str.redhat.com>
        <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org>
Date:   Tue, 24 Nov 2020 19:09:44 +0100
In-Reply-To: <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org> (Mark
        Wielaard's message of "Tue, 24 Nov 2020 15:08:05 +0100")
Message-ID: <87im9uzkwn.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mark Wielaard:

> For valgrind the issue is statx which we try to use before falling back
> to stat64, fstatat or stat (depending on architecture, not all define
> all of these). The problem with these fallbacks is that under some
> containers (libseccomp versions) they might return EPERM instead of
> ENOSYS. This causes really obscure errors that are really hard to
> diagnose.

The probing sequence I proposed should also work for statx. 8-p

> Don't you have the same issue with glibc for those architectures that
> don't have fstatat or 32bit arches that need 64-bit time_t? And if so,
> how are you working around containers possibly returning EPERM instead
> of ENOSYS?

That's a good point.  I don't think many people run 32-bit containers in
the cloud.  The Y2038 changes in glibc impact 64-bit ports a little, but
mostly on the fringes (e.g., clock_nanosleep vs nanosleep).

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

