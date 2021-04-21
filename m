Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8442A3666B1
	for <lists+linux-api@lfdr.de>; Wed, 21 Apr 2021 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhDUIFX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Apr 2021 04:05:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234116AbhDUIFX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 21 Apr 2021 04:05:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 407C0B127;
        Wed, 21 Apr 2021 08:04:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0ABB91F2B69; Wed, 21 Apr 2021 10:04:49 +0200 (CEST)
Date:   Wed, 21 Apr 2021 10:04:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <20210421080449.GK8706@quack2.suse.cz>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
 <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein>
 <YH4+Swki++PHIwpY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH4+Swki++PHIwpY@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 20-04-21 12:36:59, Matthew Bobrowski wrote:
> On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> > A general question about struct fanotify_event_metadata and its
> > extensibility model:
> > looking through the code it seems that this struct is read via
> > fanotify_rad(). So the user is expected to supply a buffer with at least
> > 
> > #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> > 
> > bytes. In addition you can return the info to the user about how many
> > bytes the kernel has written from fanotify_read().
> > 
> > So afaict extending fanotify_event_metadata should be _fairly_
> > straightforward, right? It would essentially the complement to
> > copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> > which deals with user->kernel and you're dealing with kernel->user:
> > - If the user supplied a buffer smaller than the minimum known struct
> >   size -> reject.
> > - If the user supplied a buffer < smaller than what the current kernel
> >   supports -> copy only what userspace knows about, and return the size
> >   userspace knows about.
> > - If the user supplied a buffer that is larger than what the current
> >   kernel knows about -> copy only what the kernel knows about, zero the
> >   rest, and return the kernel size.
> > 
> > Extension should then be fairly straightforward (64bit aligned
> > increments)?
> 
> You'd think that it's fairly straightforward, but I have a feeling
> that the whole fanotify_event_metadata extensibility discussion and
> the current limitation to do so revolves around whether it can be
> achieved in a way which can guarantee that no userspace applications
> would break. I think the answer to this is that there's no guarantee
> because of <<reasons>>, so the decision to extend fanotify's feature
> set was done via other means i.e. introduction of additional
> structures.

There's no real problem extending fanotify_event_metadata. We already have
multiple extended version of that structure in use (see e.g. FAN_REPORT_FID
flag and its effect, extended versions of the structure in
include/uapi/linux/fanotify.h). The key for backward compatibility is to
create extended struct only when explicitely requested by a flag when
creating notification group - and that would be the case here -
FAN_REPORT_PIDFD or how you called it. It is just that extending the
structure means adding 8 bytes to each event and parsing extended structure
is more cumbersome than just fetching s32 from a well known location.

On the other hand extended structure is self-describing (i.e., you can tell
the meaning of all the fields just from the event you receive) while
reusing 'pid' field means that you have to know how the notification group
was created (whether FAN_REPORT_PIDFD was used or not) to be able to
interpret the contents of the event. Actually I think the self-describing
feature of fanotify event stream is useful (e.g. when application manages
multiple fanotify groups or when fanotify group descriptors are passed
among processes) so now I'm more leaning towards using the extended
structure instead of reusing 'pid' as Christian suggests. I'm sorry for the
confusion.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
