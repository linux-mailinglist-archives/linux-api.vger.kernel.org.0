Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF3179498
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 17:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgCDQLK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Mar 2020 11:11:10 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35414 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgCDQLK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Mar 2020 11:11:10 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so3024779iob.2
        for <linux-api@vger.kernel.org>; Wed, 04 Mar 2020 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMEhfSBOuHBIl6yeEV5DUSKkA5QymXhcDODBiotx5S4=;
        b=M6T8IJrP2imFH0Yrd72S712RTyLiBCBZZIWukQqQGCNrzxUDeKQu+PKXQBiP9CDW2H
         mlHwDsX+W9ASgLJqXkUJnHsYp6dMv5PNAIM+ZT80/uVANpT/Tbmh4N59WO3elb0FAsQC
         gfqYvlbSsf1UyETpTERI2GLvpo1mqkHwGPlGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMEhfSBOuHBIl6yeEV5DUSKkA5QymXhcDODBiotx5S4=;
        b=ij9x6aqMTeI7E+MqVvzPes35i/A/+BNP/U0/vvCBHRfI60i882hcjHexam0b9TQoSr
         BNREQY6SjUwHE60J8R2gWmRBQmyLuK3wIOdj8J7vvncxo8c56ohjKlJLpvGxn2ru3QWe
         5HNaOBWC/0+NtTckv/HPWiGkgsX0c3riEWjjLvZFf/ayG99tn7X8JkZoWOWz9GCuV53y
         X4Z3ml5c8pyPPiu3P1BR/vwYg5hsOlFro/U7aczB5Q07zETFhW5Q24yuM5JyEHU2OXu0
         Em7weeIbr+lSqL2j7OZ7dwgsm/InCT7QmXqU10PYgKJFAGI8ixqdPcLgz+sIRhJH92Az
         wh4w==
X-Gm-Message-State: ANhLgQ1qACFNzw0fuH61vJck0mPSNNScp0sc3s50gRH073f7BTfrYupF
        is+4l69kwAAjvthsbm2H0hcIOH5Xn2O4UZNcAUgCmw==
X-Google-Smtp-Source: ADFU+vv3dF1eDGfu6HnlNnsm2H3QO09qbn9v3Km2uZitDG2c+ztP3h8bSrNDMa2kQSpJfI9anLFWwxmDff5HPQtsH5U=
X-Received: by 2002:a6b:f409:: with SMTP id i9mr2669177iog.212.1583338269532;
 Wed, 04 Mar 2020 08:11:09 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Mar 2020 17:10:58 +0100
Message-ID: <CAJfpeguyyC=E51gJ3EkQjLsqjZ8Mt35Eu7f9cQtBJaTFEcxoRg@mail.gmail.com>
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
 +
> +/*
> + * Return information about the submounts relative to path.
> + */
> +int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
> +{
> +       struct fsinfo_mount_child record;
> +       struct mount *m, *child;
> +
> +       if (!path->mnt)
> +               return -ENODATA;
> +
> +       m = real_mount(path->mnt);
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {

mnt_mounts is not using _rcu primitives, so why is this rcu safe?

Thanks,
Miklos
