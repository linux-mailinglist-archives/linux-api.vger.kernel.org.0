Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB7621461F
	for <lists+linux-api@lfdr.de>; Sat,  4 Jul 2020 15:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGDNaj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 4 Jul 2020 09:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgGDNaj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 4 Jul 2020 09:30:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2AEC08C5DF
        for <linux-api@vger.kernel.org>; Sat,  4 Jul 2020 06:30:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g20so30096575edm.4
        for <linux-api@vger.kernel.org>; Sat, 04 Jul 2020 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYXNB8sAYPR03z+7yXMvQjkDEkew3CoGHxaB14N9l3o=;
        b=c7UsYj0Lh39A+4qQDoIM8UAT0oPZ089C4wY54z+FI+hjKJoHqfZ+OSKJ7pK/eKAzO+
         T7h9fPkTqD0YYgXGbcszXQVBpQZzfECPoTaiJSGKgFPEOiS0bmZOKBCgcrfKjvEdRMi8
         ky7eDfhq2RRrihjXm8dQdD6Hedc2JnwUqwscoh1W5k3VqOOPGf5jhlp6vbXB7HwDuuuA
         l6lArMUWn4qcA6162GFXILJmBuS2liiSETUEkV2qAh7X0km7lbiqZ9omHzHGqNRHaFyc
         TmsOjTYv2/H0FKRf0bMOTc1qIUhtzUtzAS0OOkKa0/6QnCfPSRLp3MPHy4Nwd0KH+RTE
         ygpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYXNB8sAYPR03z+7yXMvQjkDEkew3CoGHxaB14N9l3o=;
        b=Nr2TNzy+bkNpc0kd+9Tk2htbxBUYJzoIXoQYJlsGbrKT2cA5aHqe3viTBsQam9Wmpy
         Qvis0Bz9E1eekxjBZk1ofosVWo2udP3K7JjKKY2RWRGLGHNlQMd7VgO3LQGJqb0EmFcA
         LVixtVfpfSfyShTIgItiNdbrde8mol9gDcdUT4k0eG5sixzt6Oilhlag2LKITjaliqMM
         NkGfmBh2U1aKjwxMLZ3gwXjViZPeVmUy87VpApngpDy9ds+9vf1HzHOacTo8tL3r8RJd
         rHjCMKq2SQaWy6p/r3ISK28xcW2xp4dHa6ZFA2KhHAr1tTxP3CeSM157gjBspGSDq84a
         gZzw==
X-Gm-Message-State: AOAM533C9ja5kH+0eGbXRXgoevXqmHF4pHOIduEcZ47UQUESVIW2VP5W
        WqqqnD+3aUjYHuG/xI8NpXQ4KgJzXnIv1+mComDy
X-Google-Smtp-Source: ABdhPJxXnEAomjGOTfVoMxiJBSuMBpETmOS+i8zhHtjzsBKGVLhQISOvjpbb5e1kLK73pS32uCKmaU1565rkftQCo+o=
X-Received: by 2002:aa7:d6cf:: with SMTP id x15mr44774064edr.164.1593869437418;
 Sat, 04 Jul 2020 06:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <e5a1ab6955c565743372b392a93f7d1ac98478a2.1593198710.git.rgb@redhat.com>
 <CAHC9VhTcFrPDSmvBBXevo-atCnxy4WK2YQ0WOeg4M1Sfz0qPgA@mail.gmail.com>
In-Reply-To: <CAHC9VhTcFrPDSmvBBXevo-atCnxy4WK2YQ0WOeg4M1Sfz0qPgA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 4 Jul 2020 09:30:26 -0400
Message-ID: <CAHC9VhTW+pTES3g7gOoCWT3tXG3NsP0KjDLLyBHs_i3HSQMspQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 02/13] audit: add container id
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jul 4, 2020 at 9:29 AM Paul Moore <paul@paul-moore.com> wrote:
> On Sat, Jun 27, 2020 at 9:22 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Implement the proc fs write to set the audit container identifier of a
> > process, emitting an AUDIT_CONTAINER_OP record to document the event.

Sorry about the email misfire, you can safely ignore that last empty message.
