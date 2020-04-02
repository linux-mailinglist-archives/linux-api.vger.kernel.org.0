Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF0D19CC12
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbgDBUu0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 16:50:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45394 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBUuZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 16:50:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id c9so4943950otl.12;
        Thu, 02 Apr 2020 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wz2udl4jL8uVsXIKEvvknDp+89q3qiXQvYqjwzsENuA=;
        b=aRjOZ91yWLCXkYAcvRP+DQShIInFEvYkD7nGRLi4Re4ieICHL1/Xl0Gyrwlm4cMaJi
         o/3UhbUqTqkrVzQeiz083+/FkMUChosx9Mp9fuOQWYsrMMHbcsOA9ax3N1nJ2ukOuxfS
         TnS8GUjGGzg0m1g5qwgHB1it0x0nC6f48efXtnrJ01I2G5S3njO/gvbalPMzLj16uNRy
         u+eKuH5gGMqTXarFY3BH5fTEqvUkaArQrOXLQHlvB+10hVC1+BvS7lqr+qcsu9u2CYBy
         0++smUGWj3lAmgUJpVV/aRrWzEfislw9De/yvXo/juD3ROPwOJsBJZE2YtZFi6Lb+gcB
         10OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wz2udl4jL8uVsXIKEvvknDp+89q3qiXQvYqjwzsENuA=;
        b=uc/vCXmYEV8eZxjzv98PWsyPo87ov4RRXJ7DevDdvVJwsBD5PAZbVHTKGlriVrwyWw
         5LWKNbyGaq1m38myTzL9mcEcqfVKZHzUyW6BcCpqsGOqA6JvBzet4rjp4C+8rJ+crbFm
         +pHz3Yqb6QrL98b44aU8EHna1jI1Pg1HrXaZwvJw2T4IrWCua2HYqiGoDR5W0DyDgvYM
         hhqfK+ifYk259OerDwHWiaqf+PsasCuBgQFwZLuH/NUxoSNPoxH23alHitHOs3sLVyWE
         uwSgpmmkiltn0Nif3pxYnzOr5fjowF4qqOPxqYSFm8r04WRRV272NmQH5YQmHfPb7Uwx
         d5zg==
X-Gm-Message-State: AGi0PuZp263vmP7bnDklKHJs0DSDO7S4H6PvIGe97jfADMyuKunB0RCF
        Xw5PlgVWkCyXkgSwBd4vi+8a4Xp5RJ2WlEicSAg=
X-Google-Smtp-Source: APiQypKh1/xKqmI29xbbAxy+E6TsH7bzE3OINN5QMXN/fFVYkIW6fMe4e1vbmBDYImXeUCrKnqaGbB1WM4VzCEoiIds=
X-Received: by 2002:a05:6830:1d95:: with SMTP id y21mr4058634oti.180.1585860624632;
 Thu, 02 Apr 2020 13:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
 <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
 <CA+zRj8XYLpa_gep+VxUfQuqeKu+=thMit-jNv1soC8Mh5H43Ug@mail.gmail.com>
 <CAKgNAkipcX47quv23SACeorSexO00nUAJR3QSTA3bFNMresE4Q@mail.gmail.com> <CA+zRj8XzqV19Z9KcyO+_V2Nkt4fgwK7QbP01GE5EL=g_xHf8Xw@mail.gmail.com>
In-Reply-To: <CA+zRj8XzqV19Z9KcyO+_V2Nkt4fgwK7QbP01GE5EL=g_xHf8Xw@mail.gmail.com>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Thu, 2 Apr 2020 13:50:11 -0700
Message-ID: <CA+zRj8UB9dagmF9FUPRLPcqzCUr2HrQQJre+_cnYzH9E-K9gaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can
 return other errors
To:     mtk.manpages@gmail.com
Cc:     Eric Rannaud <e@nanocritical.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> For what it's worth, man2/ has 29 mentions of EOPNOTSUPP (value of 95
> on x86) and 8 mentions of ENOTSUP (with a value 524).

Err.. please ignore the values in this paragraph, they belong to the
next paragraph referring to kernel code.
