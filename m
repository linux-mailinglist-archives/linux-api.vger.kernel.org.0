Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA78D182038
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2020 19:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgCKSAM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Mar 2020 14:00:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41713 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbgCKSAL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Mar 2020 14:00:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id o10so3351763ljc.8
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2020 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpqDD1Wo+HKU40oDoKA/BJI8LsaHpPP8z3qrK9mKasM=;
        b=ckkZBdQmXywHGIbczwxKoXJtM5bn1Q4zF8980dmDzUAerY42Vnt79h0/hrgko+maFY
         g6W5qtOcDU0FR7TReGj9YV2UAWuNcF/lAEUT03GfvSsuEW22s7MzLhczmTz71ew7VoeG
         9tipLpaaHNIEBXH+b/EPSFlrBcI9QWo4iyKEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpqDD1Wo+HKU40oDoKA/BJI8LsaHpPP8z3qrK9mKasM=;
        b=EEdDJJlJtRsHsMYZFBWs5CWCiYtpC70OdbHqe5w3YSULPc84+IWMWLFczE8LUtg6+K
         ACvP0U7Sr5hcYxKwCMwlM9MWEiSdAb6rPjm31YL4Tpz+7GFHmX6MtppB1FyjZOoxLMtz
         HRu1QZjAkwmKmX3x5RvnOKbesASuLlxyG6mQ/9HP3jEi2YqWp6EwFZqoZ1Md5LH9Zn7y
         MZdkUxBy0dKYbl6nRqrqjWbMv5pYpDmGJq07ArBR6TeSmWa3WYf7GMUxubQzp0leEupe
         fVbOLkP4LFEtNL2K7h5gJcTeCgTWpqhTHmTMzhbON7PJl8jKR4gxX3uoLHkLA26nyC7n
         KbzA==
X-Gm-Message-State: ANhLgQ1vUk8QIiM9dH2pOoLoazNBiK/QRzapB916u9zuVDXOj5sEe1yz
        IXoZ+K41VItwHpApFCqJvhse9J4aF1I=
X-Google-Smtp-Source: ADFU+vsr8CteEkWlolPTlsNUmpQFdgAmvYUHJQhvJkeal0qRiPPlAgEavVi//ObQn/cVp4iX1yxnxg==
X-Received: by 2002:a2e:151e:: with SMTP id s30mr2813395ljd.92.1583949609227;
        Wed, 11 Mar 2020 11:00:09 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y78sm2276927lfa.2.2020.03.11.11.00.07
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id e18so3339315ljn.12
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
X-Received: by 2002:a2e:5850:: with SMTP id x16mr2622296ljd.209.1583949607115;
 Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
In-Reply-To: <580352.1583825105@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 10:59:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
Message-ID: <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 10, 2020 at 12:25 AM David Howells <dhowells@redhat.com> wrote:
?
> Okay.  So what's the equivalent of AT_SYMLINK_NOFOLLOW in RESOLVE_* flag
> terms?

Nothing.

openat2() takes two sets of flags. We'll never get rid of
AT_SYMLINK_NOFOLLOW / O_NOFOLLOW, and we've added RESOLVE_NO_SYMLINKS
to the new set of flags. It's just a separate namespace.

We will _not_ be adding a RESOLVE_XYZ flag for O_NOFOLLOW or
AT_SYMLINK_NOFOLLOW. At least not visible to user space - because as
people already figured out, that just causes problems with consistency
issues.

And yes, the fact that we then have three different user-visible
namespaces (O_xyz flags for open(), AT_xyz flags for linkat(), and now
RESOLVE_xyz flags for openat2()) is sad and messy. But it's an
inherent messiness from just how the world works. We can't get rid of
it.

If we need linkat2() and friends, so be it. Do we?

Could we have a _fourth_ set of flags that are simply for internal use
that is a superset of them all? Sure. But no, it's almost certainly
not worth it. Four is not better than three.

Now, some type-safety in the kernel to make sure that we can't mix
AT_xyz with O_xyz or RESOLVE_xyz - that might be worth it. Although
judging by past experience, not enough people run sparse for it to
really be worth it.

               Linus

PS. Yeah, we also have that LOOKUP_xyz namespace, and the access mode
namespace, so we already have those internal format versions too.
