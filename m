Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9701484E8A
	for <lists+linux-api@lfdr.de>; Wed,  5 Jan 2022 07:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiAEG6N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jan 2022 01:58:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46586
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbiAEG6N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Jan 2022 01:58:13 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4943F3F1EA
        for <linux-api@vger.kernel.org>; Wed,  5 Jan 2022 06:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641365892;
        bh=K7KhCCRGwBeqa84RMcXQSaKtKWeSUZPZtO3lWY1KoAw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZL1QmTbRjvPyabaSaAmgz9PHWn7zA0KLKXmTGU+PTzss7/kXDGN0vrPoGnSHzjN3e
         CBkXEyL/+maSBljjXzTmTZU84DQQSGp9y3CcUwp+t/SvynQmyO8O/NnNitjo/LKGdb
         9kUSYPUkY9pLafoMCjUn+bRcMdeaBAOYEfOv/8QgpQd8/ArYc18jGDnajimgDxTvz/
         hUJXgrCK/z2m/j2gMZxgZfF8nOtvyNDwBimlDowmx+iQPn60M4odwJpdRQnCp1DkQb
         Q4Gg3KuN5anvP9CEOBsNXIf1lWI9w3FYy2L25TtigGQLQ3c3QEXRWE5XWZgYqH/APq
         Mhkg97mKmU9Lw==
Received: by mail-oi1-f198.google.com with SMTP id n2-20020acaef02000000b002c6c1c37a03so25174905oih.21
        for <linux-api@vger.kernel.org>; Tue, 04 Jan 2022 22:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7KhCCRGwBeqa84RMcXQSaKtKWeSUZPZtO3lWY1KoAw=;
        b=O5773Xj3hmMxLAPNna2BxPHnYblOI+p9ol9fLr9i/vOyr9S2dkbuBPYofgJAs8I3lb
         x78F66zdePgS7u0lGVHxonRTZRzkwoUQDLNQOSMafEosiWVDI45fr932OAi35lM/sOLx
         mCfjZWDC9TuIKUxjrBm7OdjqHcnbfrTHy8ETREplEg0+PEYg12SwAHgJOHhuymoAYDSl
         9kqIpi7IuY2NvJpjAf2M2wkt/7z8j7B96UPoNSRcwEUZdi3P9Ft/APhXKqOrYa6iaNt8
         7BLqQSDpeZ/QMQdxa9hWNP3x3eFpvZ/qkSAgkgcMB+TV2WLCVk/IgevlygoMXiJXm+vp
         49lA==
X-Gm-Message-State: AOAM531c80JfI7n63i7sBfkpacgbE/NhAiQ1JjNWS+lps0aW1XN9cPpF
        Jc9YD6GuqBP6GBwYCNCiUXt5DvtRpkz2llYvZ00qAVwO95B9ABBv0hwhZTqvTbIrE7A0h8LOC2x
        Rz4j0pt/NMc3QggmHWsiY6zKEVN0lPrBq9kooOBZlRxgDGVRQdfjSXg==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr37862056oti.269.1641365891200;
        Tue, 04 Jan 2022 22:58:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNEUrV1/+wUr9dPal3uCYsIG1bY6qJIscVrBikSe+RUdub75zP+CxdWyhqtxOWGkSB4MQIVWIg4kS3Iyo32aI=
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr37862043oti.269.1641365890949;
 Tue, 04 Jan 2022 22:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-13-matthewgarrett@google.com> <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
 <20220105064827.GA30988@srcf.ucam.org>
In-Reply-To: <20220105064827.GA30988@srcf.ucam.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 5 Jan 2022 14:57:57 +0800
Message-ID: <CAAd53p5A9ajyP=8edXW20MB1eLRAF3SsmXfdnkA2isBJD2Bd+w@mail.gmail.com>
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 5, 2022 at 2:48 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Wed, Jan 05, 2022 at 02:25:41PM +0800, Kai-Heng Feng wrote:
>
> > This patch breaks ioperm() usage from userspace programs with CAP_SYS_RAWIO cap.
> >
> > I wonder if it's possible to revert this commit?
>
> When lockdown is enabled, or under all circumstances? It's expected to
> be blocked when lockdown is enabled - allowing userland to use port IO
> would potentially allow reconfiguration of PCI devices in ways that
> could alter kernel behaviour in ways relevant to security, which is what
> lockdown aims to prevent. What's being broken by this?

Only when lockdown is enabled.

The affected system from the customer has SecureBoot enabled (and
hence lockdown), and the kernel upgrade surprisingly broke ioperm()
usage.
The userspace program is proprietary so I can't share it here.

Basically this patch makes ioperm() a noop on SecureBoot enabled x86 systems.
If reverting is not an option, what else can we do to circumvent the regression?

Kai-Heng
