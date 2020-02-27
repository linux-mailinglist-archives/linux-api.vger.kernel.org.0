Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B712E171432
	for <lists+linux-api@lfdr.de>; Thu, 27 Feb 2020 10:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgB0Jgt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Feb 2020 04:36:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46056 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgB0Jgt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Feb 2020 04:36:49 -0500
Received: by mail-io1-f65.google.com with SMTP id w9so2422145iob.12
        for <linux-api@vger.kernel.org>; Thu, 27 Feb 2020 01:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSFAYumXnIb4mNx6pb9jSCJtikoAu1fiU5AFDR41HiM=;
        b=nMST/l5yp4EsOlkQkjz+oyXVo6tR4nbd5GbUbI5x84hWOMcXm3M7y8DV6kt66nn7b7
         GIlsjbkbx3vQijL/6+LHbt8H5ZHfFqOOXohYBjwIMdjJnBLoeC35oZ4Yl225QYdACe5/
         kVd9f5v/M5gtnQTRoS4CTQDPAYtlf8yBp6HVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSFAYumXnIb4mNx6pb9jSCJtikoAu1fiU5AFDR41HiM=;
        b=QFxuNCKAqWYNDc7rvJ9MjZi5veMzbgW6vjUkIbtaOctTCZmP2KWd1gm+M4KkpHarM7
         BguMq4c11tM5N2ms+oLG5o29jTENgbkDsLxiqsod2+W2k7LnEh6Xdpz9R5rzS5GO0/l/
         cbcRsKMIGbhFGJTpgNd0Tv+kc0uGiTyVgfJYpqUlpf1+zZ0dgGBJ79sRPFG8QdrZICu6
         EcQloXN3DABOZsP2tYYaqcwyNv4sp2YwYrwK1x04fUZ+5A6f0pZ3NDBP7SXO46r6xGlI
         Z0OFkXkOmd1TMkiezKz5/eIeUHeQ4LFRBPBavw7vPcbF71JcSMftN5kAZGmg6u/e2KCB
         uuCA==
X-Gm-Message-State: APjAAAWYQnaWFXqf6SUh6EFV77Z5Mzf+zJrbFRVkttVOKuNlG3CpQRiX
        Nix8fmtM+ai1u8WtK5cGSsZZ/vmGyb9hn121Y0BSjg==
X-Google-Smtp-Source: APXvYqw5v6WxqDR1yb3LDbMMK6C7QWK8wr5eU3zXIVtb+M97KWiW/29yrC6ghVKgpIwZqN9mr5PMGU2nHAVDTWUTGO8=
X-Received: by 2002:a05:6602:382:: with SMTP id f2mr3597157iov.174.1582796209051;
 Thu, 27 Feb 2020 01:36:49 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com> <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
In-Reply-To: <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Feb 2020 10:36:38 +0100
Message-ID: <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 27, 2020 at 6:06 AM Ian Kent <raven@themaw.net> wrote:

> At the least the question of "do we need a highly efficient way
> to query the superblock parameters all at once" needs to be
> extended to include mount table enumeration as well as getting
> the info.
>
> But this is just me thinking about mount table handling and the
> quite significant problem we now have with user space scanning
> the proc mount tables to get this information.

Right.

So the problem is that currently autofs needs to rescan the proc mount
table on every change.   The solution to that is to

 - add a notification mechanism
 - and a way to selectively query mount/superblock information

right?

For the notification we have uevents in sysfs, which also supplies the
changed parameters.  Taking aside namespace issues and addressing
mounts would this work for autofs?

Thanks,
Miklos
