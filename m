Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F0F1792E0
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 15:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCDO60 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Mar 2020 09:58:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36968 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCDO60 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Mar 2020 09:58:26 -0500
Received: by mail-io1-f68.google.com with SMTP id c17so2711201ioc.4
        for <linux-api@vger.kernel.org>; Wed, 04 Mar 2020 06:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MI1PXuWt7Kag0MFTc+PiKW4eyxOQoHf1qp779Es8aXg=;
        b=jlEbGqj0JV8uts4QRzcS6Eajtw0tKvhkbeliNCbF4uNcgjKTS/ufjxuns+h7Dpv6oK
         iRjdlxhkwkZI1FmdhgsHRZm18X+J/tCJza8pnjG/RS/TKmekikpIX0g4Ktub7s/SxPOV
         trmM3oYR2IE7l7X78+F/LxlrLp+ecQgRRpBjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MI1PXuWt7Kag0MFTc+PiKW4eyxOQoHf1qp779Es8aXg=;
        b=X2uMvyYVztUi5WZpES2aAbRUYG1I7rWX3irl7KI1/7LPIC4tRKd85Kf+ekKk1A0DON
         x/ZPFjUQ8L4pqFLAZQzaVxzP+iccLWD8PQse5gAExCDTYZeunv5aiAVqRxjzVzpFi0vJ
         xi6jOCMQSDki5daTEZ0vW6dTm3vtU7yJKCuEm9Nm6zfwPY6Zv7rhwzHyqY7MeR2uV4dq
         dJQEH+zIoL1AdbGyIUUTV3IaW4f+StbTLSWepzQ7LDz1nkeTfpj3icu/RwOkWfGEqum2
         etaSSyOD4UP7xFVRbNHzbSeTBzQLd9I63d5HpGKqfYQ5nbo73y2g1zhxYguB3ftA7yr9
         AVSg==
X-Gm-Message-State: ANhLgQ2Dnfo87yT9oSwaLx8pQetJeu0H5Ech1AxPV5rlWuUoCFL/w8Z2
        aVUZGebGaCfsDjcv2nFe9HflNwgvUfIyGK+OM957VA==
X-Google-Smtp-Source: ADFU+vt7iszIUbYisTGd86KHNUYtvuTdfoY/g3ldBLGb8T53mnRCU8tRd+55HaV44wyYtBstlDMXhGVD9Q344+TQJSs=
X-Received: by 2002:a02:558a:: with SMTP id e132mr3150631jab.58.1583333905701;
 Wed, 04 Mar 2020 06:58:25 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Mar 2020 15:58:14 +0100
Message-ID: <CAJfpegtcNorH0uBbmodOj5WZXRjXnbzRXWbX7+A=qf02LDJCtg@mail.gmail.com>
Subject: Re: [PATCH 10/17] fsinfo: Allow mount information to be queried [ver #17]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 21, 2020 at 7:03 PM David Howells <dhowells@redhat.com> wrote:

> +/*
> + * Return the path of this mount relative to its parent and clipped to
> + * the current chroot.

And clipped to nothing if outside current root.  The code doesn't
appear to care, which to me seems like a hole.

And btw, what is the point of only showing path relative to parent
mount?  This way it's impossible to get a consistent path from root
due to mount/dentry tree changes between calls to fsinfo().

Thanks,
Miklos
