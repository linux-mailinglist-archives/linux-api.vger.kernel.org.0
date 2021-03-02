Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6CD32B2CB
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhCCC6K (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 21:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349460AbhCBIZK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 03:25:10 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA8C061756
        for <linux-api@vger.kernel.org>; Tue,  2 Mar 2021 00:24:22 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id j188so4220865vke.13
        for <linux-api@vger.kernel.org>; Tue, 02 Mar 2021 00:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHK4JnR63Uj2zkrrF0LLWE9CLFkTJjc+hf2aOe/76Qk=;
        b=H/j9/7gFw2DSIIxJWfE2/xBE/Yg6n7P5kS9sLr9CPF4trQJhsqEROta/M/bJ2QXUx1
         TQ6HkVmR1tbSst1LKtM6ER7UutBYwy8dJBQ6TQmywRbBLBARcPDat0b8LD9rVXgdmzb7
         91wMygTfcwxGZgI3YCAuTNY3wTtGet27V8P4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHK4JnR63Uj2zkrrF0LLWE9CLFkTJjc+hf2aOe/76Qk=;
        b=bFdz2niTtAuwoRjyHa9sEAmgNg7MqbGg9GzwCSE7NvmOxLQs1LNZ+vNjG/4e0d+zJE
         a5uWUnhzgsDBMDDqj4ftvJJzhYEZyX1F8ktdHAbdwsORjqSt2KOXwjnRxbS/QRcjCs74
         PYjOIHmMSAVXS25+2Pf4TRhoFfULKHAanOE1CpNZhVktlKfcRz26qHg0zGeyTb6Fcj3t
         calNrj2vnpsLAFEK/yvzotf/VmGHYPE1nxBHSJuz3kW3GE/16LX/2cGk9ohNdMj0OCO1
         Nps7Xktt4yoGctYddc0tg7fWIGITn8SLtgDtv30Z9S7NLzB2Mhgw3ylcWTIEBz4CpLwr
         dvPQ==
X-Gm-Message-State: AOAM531jNXlcXYvHv4eMpo7BXzX0nQu+X9FwheYIZAg9KpT6DWpZP8Fa
        xjZV67uxCCxJhKHETPm9lutc+SzmL1Hb4IsRpFK9ACU/3ZY=
X-Google-Smtp-Source: ABdhPJyg9uJQlZeySdGkEzfeIqtfA4o+qgIsYZgchqZTEcO+yLujsqLgEc5JPQT91SzH6AgPgzXtE+ck7+u+S9tYeO8=
X-Received: by 2002:a05:6122:33:: with SMTP id q19mr10246650vkd.23.1614673462060;
 Tue, 02 Mar 2021 00:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20210228002500.11483-1-sir@cmpwn.com> <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga> <20210228040345.GO2723601@casper.infradead.org>
 <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga> <20210301190903.GD14881@fieldses.org> <20210301193537.GS2723601@casper.infradead.org>
In-Reply-To: <20210301193537.GS2723601@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Mar 2021 09:24:10 +0100
Message-ID: <CAJfpegtDQ6NG6vZeS9kiRq-VwbS06TD4X=QvtGUHkX_0Tm65nA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Drew DeVault <sir@cmpwn.com>, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 1, 2021 at 8:42 PM Matthew Wilcox <willy@infradead.org> wrote:

> (as an aside, i think there's a missing feature in posix -- being able
> to atomically replace one directory with another.

RENAME_EXCHANGE.

Thanks,
Miklos
