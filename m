Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1842E7153
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfJ1M16 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 08:27:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46758 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfJ1M16 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Oct 2019 08:27:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so7613725lfc.13
        for <linux-api@vger.kernel.org>; Mon, 28 Oct 2019 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGx03eBCF/ZR/TJOysj+IjW5mFyYp/9PThI32ukvUbA=;
        b=TlTg/tPa+Cb2+B62nozWpbPUhV8ULgTksO+p1fl72Kr55S79U99txmRCJ60LBlWifg
         3f15B172AD36UWaHBr3vrgBAc9IpQ2hR+Y793XsAT5c3FmiBK+BJ3mLyHFGO7kplB+ms
         x7VgD3i+NS30ikRDRUeMZ55lKRiyMQEhf4pU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGx03eBCF/ZR/TJOysj+IjW5mFyYp/9PThI32ukvUbA=;
        b=WKgERODF/o2YlwANxVXV75kTozYbMiSrKUVf/liAAV7M7So1RCQntDfTZsFOsqvJxc
         lokeUaV4MlYdMsuPb8neE+Dz8mT2yxpbCEMisl/K43p4f2uUw5v07+blj9JDuJXUVLoR
         m1zWOuN0Buj4uhy4Hm8MdVgcbUCYW6c+cvGR5wTZfGXQ0gpYLOgjPyIPScvC0VqlCDjJ
         YkyogK7G6tpedVoFUguqFMFfh0XP3MUEgK/zyXzWS0g2vuuEwPBvySowVqwA7T41AMpb
         CNG1J/IKVCxdg+/3DAWKUHCsK/sdJW6DLPdgq64aLKUQV1V7oo+gtGAf45fOIQzYkWcL
         lHOw==
X-Gm-Message-State: APjAAAXMa2j0bCWkYl1k4aS7KsjLNIEYG6+ksuAiCmaO9hmBk4eo/9j6
        Mjf2K3hgXFYSQAK7TqlqTLUuw/mm4qmMyw==
X-Google-Smtp-Source: APXvYqx/JHnQ6IIiN61vG6MPMSIdyfEwfgGqJygORcFXoVz0YQoJNmN57IIbKWU+0YS+9hU490x3xg==
X-Received: by 2002:a19:7f15:: with SMTP id a21mr1752715lfd.169.1572265675868;
        Mon, 28 Oct 2019 05:27:55 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id e2sm5461424lfc.2.2019.10.28.05.27.48
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:27:49 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id a21so11101270ljh.9
        for <linux-api@vger.kernel.org>; Mon, 28 Oct 2019 05:27:48 -0700 (PDT)
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr4826222ljd.1.1572265668380;
 Mon, 28 Oct 2019 05:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <157225848971.557.16257813537984792761.stgit@buzz>
In-Reply-To: <157225848971.557.16257813537984792761.stgit@buzz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Oct 2019 13:27:32 +0100
X-Gmail-Original-Message-ID: <CAHk-=wiCDPd1ivoU5BJBMSt5cmKnX0XFWiinfegyknfoipif0g@mail.gmail.com>
Message-ID: <CAHk-=wiCDPd1ivoU5BJBMSt5cmKnX0XFWiinfegyknfoipif0g@mail.gmail.com>
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 11:28 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> This implements fcntl() for getting amount of resident memory in cache.
> Kernel already maintains counter for each inode, this patch just exposes
> it into userspace. Returned size is in kilobytes like values in procfs.

This doesn't actually explain why anybody would want it, and what the
usage scenario is.

             Linus
