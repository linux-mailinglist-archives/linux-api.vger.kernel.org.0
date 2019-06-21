Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BA54EF78
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 21:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUT31 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 15:29:27 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:46340 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFUT31 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 15:29:27 -0400
Received: by mail-io1-f44.google.com with SMTP id i10so386554iol.13
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJl5y4V8VgS7JZxlv11fQ6wHrOa/T1ru3Q+ysKKp/3w=;
        b=kjFTZ8AiEb8WRwbQHtL2VjEfY4qz+tHy2NO/qwJ2qerHZehrPZZKALXI+/JDQlMAFH
         zvM6lqyG26h0Mjmj8pE3lcIPPeqWSRks8nK/hAQGyaiZsdXeDq8egvGZZE0AzNmyfGnb
         xv4W3G1tCKbUC/KlrtmWVxx/jFipAx5geNspxTUXuTVJjkZCi/+0+0dL9sjN78ydhiHs
         gxGHy2ZEVlznzm+YBKesFBZOv8q9uh9prCQt82ejjEUxddEb62inj9bzMDfeMLYf105c
         JnAZfNAEyu2Un6JYvvZ5N0gHwqW1RI6dVz6mbHAGE4zKfxPHYYJwLbYfDtGastjNfnhY
         WZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJl5y4V8VgS7JZxlv11fQ6wHrOa/T1ru3Q+ysKKp/3w=;
        b=V2mWlmbK8SqtF0AZS1vvs6F9s7nomNiEUNelV8p0g15hSRgQG1lU5vNK8imzdK4K+F
         1Cm86g9sWaTgRXpLgxsh7GvI7jpKaJJ+oqs+cYABG9KTyvQodPscREU4RU+XxX8rFw5M
         8PYElR3Xki7SQ8c3NvDVvMXZ9Ib32Kpq1sXr2skfNIOd1jOf26KQf0lncnXx6ZvHNJkK
         2d1fiGeHF/K8bBijhD2ku8PI3cn7xnPYhf1nk1gw+yr0gCDwyDyK26b1faDAeEHGLds6
         /m9Heswvf7efwsh+UZx9piiguV8u9rkUrJtVuHXH1tCc8iLkg8eKBN6SDVVPPaJUW9Ky
         Glag==
X-Gm-Message-State: APjAAAX6UMShIYethrHHs10XDQwuTJ7lLrWYesxZKwdvPoy2dGlOuuSd
        soEVTGkMdnhQXAcFUZD4D9LQ/UCvUPz42ptYqb5Dl+1yOQI=
X-Google-Smtp-Source: APXvYqyFzcKFaF7lHxsc9+q4k6Wy/9j/XZgbZz717HW3IU1H7lLU8ohZMo7FLQ6SmQ/NPOXWZuQxwnEp1PKw44GzTUQ=
X-Received: by 2002:a02:914c:: with SMTP id b12mr27661552jag.105.1561145365939;
 Fri, 21 Jun 2019 12:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-3-matthewgarrett@google.com> <201906202022.B09ED6E0@keescook>
In-Reply-To: <201906202022.B09ED6E0@keescook>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 12:29:15 -0700
Message-ID: <CACdnJuusHEWFMfZmCvyaK=c40Z=4HM7sk1y0BaFs1OMbjKc-jQ@mail.gmail.com>
Subject: Re: [PATCH V33 02/30] security: Add a "locked down" LSM hook
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 8:23 PM Kees Cook <keescook@chromium.org> wrote:

> bikeshed: can this just be called "security_locked_down" without the
> "is"?

Sure.
