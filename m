Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B619DBEE
	for <lists+linux-api@lfdr.de>; Fri,  3 Apr 2020 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgDCQnJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Apr 2020 12:43:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34140 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404111AbgDCQnJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Apr 2020 12:43:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id d3so6688940oic.1;
        Fri, 03 Apr 2020 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVVl9R8FYEud+/akr6L98oF7IK5MhLMqkoMHdc9p548=;
        b=DFdFQtFD7QVW4P2Mf0M1+1zU5UL9wKQSm6qLGed5MyDKHVet5exCtltsiwjH5JPimD
         3EvKvUVu+Ymt8a085qHWHpo6X2L7m1JPf5CrhSIdQ8OrJ3z2ZSfO7F44QUmqe/MF2kjq
         4RZNEN/AasdhK//yr1F1Uyirq71suZMmkzLhXppTJkkuYSkoMQkKaDQcdwMq4xdf1unB
         LcfGheihyFmi1tcrlEue19sITVGrF3KrWYg8V44WweVii0nIExjSl5uD6l+MQz6K14pS
         RD8A7Drf5ic9OhuChBh7xYfV+mv6Uosa7RhW36lN90CkbB1dRiICaaifsa09ffy7wovg
         dSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVVl9R8FYEud+/akr6L98oF7IK5MhLMqkoMHdc9p548=;
        b=ZI96+0zuxLZHoecotxXtmJFxozeu+5TjhEBaE/wxGnM2tIDTSZdvpUsbU3hSK9t6ba
         1Auf6n+Goq2X1YEEfn7+JdvmDJmJF1O5TU3s8lPYo4ZOPRuijAD/eklYVOxjY3cCBiz3
         zulBOSUQJ7XachgJf/u7dj8PM5sq16SnkNm7SHETHdoSQYsOmAJiy3GuUt48FRjUyGrq
         be8jM1gAhbGGNUjqqkLE+k3QpIg4dwdzAdRF2zpC+y+lbL6dJLQl5G1/dsHlvck2ApL/
         12LIM6yGec0MV1dJzxsrOTvXLzMnSf6PaR9X3tpi+ZY9qMyVS3SaZbJla2NUaTqVxtGl
         GL4g==
X-Gm-Message-State: AGi0PubUM6RHNrktTnN3r0EJC0grD2Hj4vM/qJjOz1uVRbV3seSTLEZn
        eOx/8i91fL3FCKd1OEkEKdKaaoJnYrslO0qoHoGU6gF0kc4=
X-Google-Smtp-Source: APiQypIlv/zPSg2WNnoHU8Yt2rkFV72BQv7rJnb3qrsC7WQMiyQXI9QXoG1nJ3jgX2kvRGgqjPro34uK/nmsivpbswk=
X-Received: by 2002:aca:3b85:: with SMTP id i127mr3523346oia.123.1585932188037;
 Fri, 03 Apr 2020 09:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
 <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
 <CA+zRj8XYLpa_gep+VxUfQuqeKu+=thMit-jNv1soC8Mh5H43Ug@mail.gmail.com>
 <CAKgNAkipcX47quv23SACeorSexO00nUAJR3QSTA3bFNMresE4Q@mail.gmail.com>
 <CA+zRj8XzqV19Z9KcyO+_V2Nkt4fgwK7QbP01GE5EL=g_xHf8Xw@mail.gmail.com> <cb4c685b-6c5d-9c16-aade-0c95e57de4b9@gmail.com>
In-Reply-To: <cb4c685b-6c5d-9c16-aade-0c95e57de4b9@gmail.com>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Fri, 3 Apr 2020 09:42:57 -0700
Message-ID: <CA+zRj8UcOyHSWhrWSHr3eDQ-4mbze9fuZTSGf7zBfi2L57WuMw@mail.gmail.com>
Subject: Re: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can
 return other errors
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Eric Rannaud <e@nanocritical.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 3, 2020 at 12:02 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> Actually, there are 0 mentions of ENOTSUP in the kernel
> (other than in tools and samples). The constant that appears
> in the kernel is one called ENOTSUPP (2 P's) defined as 524
> in include/linux/errno.h !! Yikes! What a mess!

> ...

Fair enough! I didn't even see the extra P in ENOTSUPP when I was
looking at the kernel code. Thanks for the detailed analysis.

Eric
