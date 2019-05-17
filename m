Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD70221406
	for <lists+linux-api@lfdr.de>; Fri, 17 May 2019 09:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfEQHN3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 May 2019 03:13:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfEQHN2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 17 May 2019 03:13:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97937308FF32;
        Fri, 17 May 2019 07:13:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E59555D6A9;
        Fri, 17 May 2019 07:13:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <F67AF221-C576-4424-88D7-7C6074D0A6C6@brauner.io>
References: <F67AF221-C576-4424-88D7-7C6074D0A6C6@brauner.io> <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk> <20190516162259.GB17978@ZenIV.linux.org.uk> <20190516163151.urrmrueugockxtdy@brauner.io> <20190516165021.GD17978@ZenIV.linux.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11454.1558077206.1@warthog.procyon.org.uk>
Date:   Fri, 17 May 2019 08:13:26 +0100
Message-ID: <11455.1558077206@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 17 May 2019 07:13:28 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> If you still prefer to have cloexec flags
> for the 4 new syscalls then yes,
> if they could at least all have the same name
> (FSMOUNT_CLOEXEC?) that would be good.

They don't all have the same value (see OPEN_TREE_CLOEXEC).

Note that I also don't want to blindly #define them to O_CLOEXEC because it's
not necessarily the same value on all arches.  Currently it can be 02000000,
010000000 or 0x400000 for instance, which means that if it's sharing a mask
with other flags, at least three bits have to be reserved for it or we have to
have arch-dependent bit juggling.

One thing I like about your approach of just making them O_CLOEXEC by default
and removing the constants is that it avoids this mess entirely.

David
