Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5979FEF7
	for <lists+linux-api@lfdr.de>; Thu, 14 Sep 2023 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjINIuW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 14 Sep 2023 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjINIuW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 14 Sep 2023 04:50:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC84C1FC4
        for <linux-api@vger.kernel.org>; Thu, 14 Sep 2023 01:50:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9adb9fa7200so90067966b.0
        for <linux-api@vger.kernel.org>; Thu, 14 Sep 2023 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1694681416; x=1695286216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=If2+Px/j1i2usZxS7gF0O94KGwHevrnZjdMBKU2+tpg=;
        b=jIQ2VYXgZuR/ZKNRr4CLdrhSJts6SWFagvZvk7PCo5Q20GmK8DcL8veOTRYLtyx3ee
         NJFySQfrltJJ8Sy8s8D41pV2nX6zr1ctRMrWuViEfU0jyPoMe069b6hSIQavd5LOn2WA
         Tn9KP5PgOFnjYXlFX/5wC6Aw8C64/lmxRv+0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681416; x=1695286216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If2+Px/j1i2usZxS7gF0O94KGwHevrnZjdMBKU2+tpg=;
        b=DWsPDA8GxvyD6Qz+9D+nTAgVoBLEwJV+k3wMhIk+Y+LbdDpOIGOm6R6iVRusXnXgRW
         B8WQwTpnvi8wpyeRVlTAouy2MfWyDAt+owKSEzBalnO5PuYsn4OftHQ3zdzeLKOEvRyT
         AAHfvArw5f+fDsnwxgRB7d/v1CEUw9qZ62ZPVBavg38CMLMnYrtxHyy+tGCkiEkpY0EP
         24UCvfIIEpcc3Q1I6QE/yv0wOBkx/rkgn7+biUAIdYUpWdkS6zvbPbNUQvQdNg6rG5sl
         7fRmR4LhOIR66WzhqcESj2XUSEybdeCun6MxDena5yW//T9Adb1fabyi7V3037A5bPEl
         pSsw==
X-Gm-Message-State: AOJu0YygESEBcwccH+XKHPH1OIvTnTJZBlInOl5H5dsYMkW0Boe/RWyh
        a/n5cPUbL8IsTi0RI/z30YjlXBoXg7L6ChtaGRsVXQ==
X-Google-Smtp-Source: AGHT+IFq8m9XcKLtOZhLaV1arOz7ua+SOqJfLVSYytrKwDeB8LEuqfrYb76LxaqAosv+sz3tPa3lHMJ0qAc+k0UEbOc=
X-Received: by 2002:a17:906:cc16:b0:9a5:a543:2744 with SMTP id
 ml22-20020a170906cc1600b009a5a5432744mr1507370ejb.33.1694681416107; Thu, 14
 Sep 2023 01:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
 <CAOQ4uxh4ETADj7cD56d=8+0t7L_DHaSQpoPGHmwHFqCreOQjdQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh4ETADj7cD56d=8+0t7L_DHaSQpoPGHmwHFqCreOQjdQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Sep 2023 10:50:04 +0200
Message-ID: <CAJfpeguE97q=esmS6zE4OaZBwkBBWykwH1MTnUvLeHcfb7NeTw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 14 Sept 2023 at 08:00, Amir Goldstein <amir73il@gmail.com> wrote:

> > +               if (ctr >= bufsize)
> > +                       return -EOVERFLOW;
> > +               if (put_user(r->mnt_id_unique, buf + ctr))
> > +                       return -EFAULT;
> > +               ctr++;
> > +               if (ctr < 0)
> > +                       return -ERANGE;
>
> I think it'd be good for userspace to be able to query required
> bufsize with NULL buf, listattr style, rather than having to
> guess and re-guess on EOVERFLOW.

The getxattr/listxattr style encourages the following code:

  size = get(NULL, 0);
  buf = alloc(size);
  err = get(buf, size);
  if (err)
      /* failure */

Which is wrong, since the needed buffer size could change between the two calls.

Doing it iteratively is the only correct way, and then adding
complexity to both userspace and the kernel for *optimizing* the
iteration is not really worth it, IMO.

Thanks,
Miklos
