Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1779117A781
	for <lists+linux-api@lfdr.de>; Thu,  5 Mar 2020 15:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEOeB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Mar 2020 09:34:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39585 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgCEOeB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Mar 2020 09:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583418840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JeWSvoZf2tZsXfDObLxDYWWnv9Q0RISNvmtrEsPHEiU=;
        b=CDbPos2EUVuRd4qjLVxO0K4zHGTwYcSajj5CaieGMN40xL+5egFQUK956FmOsTK2xbhPGE
        nE31ge1TSAIvEepPOXjsD2qvQAGi+5Ls/tqO2EGYnQx3CgU2/pgssfVOTTzr+QKd+tUcjF
        haWfZyUC+KXmzf50bOszY1y22dV6Tz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-CaEK44FcNs-FLCvsKtIb1Q-1; Thu, 05 Mar 2020 09:33:59 -0500
X-MC-Unique: CaEK44FcNs-FLCvsKtIb1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED613100550E;
        Thu,  5 Mar 2020 14:33:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD35484D90;
        Thu,  5 Mar 2020 14:33:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87y2sjlygl.fsf@oldenburg2.str.redhat.com>
References: <87y2sjlygl.fsf@oldenburg2.str.redhat.com> <96563.1582901612@warthog.procyon.org.uk> <20200228152427.rv3crd7akwdhta2r@wittgenstein> <87h7z7ngd4.fsf@oldenburg2.str.redhat.com> <20200302115239.pcxvej3szmricxzu@wittgenstein> <8736arnel9.fsf@oldenburg2.str.redhat.com> <20200302121959.it3iophjavbhtoyp@wittgenstein> <20200302123510.bm3a2zssohwvkaa4@wittgenstein>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     dhowells@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        metze@samba.org, torvalds@linux-foundation.org, cyphar@cyphar.com,
        sfrench@samba.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3606974.1583418833.1@warthog.procyon.org.uk>
Date:   Thu, 05 Mar 2020 14:33:53 +0000
Message-ID: <3606975.1583418833@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Florian Weimer <fweimer@redhat.com> wrote:

> Will there be any new flags for openat in the future?  If not, we can
> just use a constant mask in an openat2-based implementation of openat.

One thing we might want to look at is implementing support for
lock-on-open/create and sharing modes in openat2().  Various network
filesystems support this.  Wine, CIFS and Samba particularly might be
interested in this.

David

