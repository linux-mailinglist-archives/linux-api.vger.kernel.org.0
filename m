Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CEAF59D1
	for <lists+linux-api@lfdr.de>; Fri,  8 Nov 2019 22:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfKHVZj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Nov 2019 16:25:39 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33480 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKHVZj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Nov 2019 16:25:39 -0500
Received: by mail-lj1-f170.google.com with SMTP id t5so7703783ljk.0
        for <linux-api@vger.kernel.org>; Fri, 08 Nov 2019 13:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ENBnwcqe6fWqMmsRADkYTeocTczwlZaaXSwAGVapD4g=;
        b=SJcWPSa7KLVzKx5Y9P4kWwJLg0Jaj0s3ma6aIUYuRxSrRxR90xPsnPjXQIJpCuzp2O
         T4svU6O3gSnyJdrsmi09gAKSGwIWVKsNbARh3LkzehOjPFp3xsJN3TE098FfRnmbh5aA
         mM0TI/aQHKRu+RWMV97PXOHc/hj5SkLT/ura/6u1y1WgwCT9m0L8KxotNSCw/ZvVhsuG
         mJLgKTR3cOLcLTnWs8B4zuZSTUgXKtWvfdS/RHf50MsqRmCYK+CSko5pH3cDjaNpSxx0
         TcUS6jNbXvHWAEcX7Gec/Buw8R7F+cbfrAW+V54QiemJLdRHtujmXr/I4fipQTLI7HLb
         H4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ENBnwcqe6fWqMmsRADkYTeocTczwlZaaXSwAGVapD4g=;
        b=bvRGuJp7N5/xgx/OA1f5MJI8URj2XKG2DiGYX7jUC4+xu+3apwuze09jxHI9h6btjx
         ISNssj4fPsHJimCZ9PxWCPVE7sxjUm9Ez4xAg2FwMyB0Ec8g82GN/02aM0Jvaf/Cf+n+
         NzFPm2vUQKJlnI+Y/tfNOMb/NsLGLSlvJZKrnXoLgpaFu0ZmtJkLYOc9GBydKJQD+/Fd
         oNj/QovTCs8Hq+NhAHG5ScVuEZwQx7xONHtxpXCcFErV1VET6JqsnU5srmvwcpDTrrGJ
         HN3M7HGp2fsrD2yPd/rEWQtvwKWg7xBYySp4SMMpd2+QhyDsUAC4ilsNeshygwgI2Irn
         mWnA==
X-Gm-Message-State: APjAAAWPf/P1jpylHgqmwkSqTxK326T+kgMH/Xr4Q4bheZNYs9tgDMQE
        Loi6nEp6Hoz8WB96ZBIJde5BCI3A4OQQdMd5MOG8M6jP
X-Google-Smtp-Source: APXvYqyd9vM7BgjOgknR2+cECns5a1UiwgUdpoJauM4aoqVxdMpXlqBNF3q6cxwicC8S4mjzNbDZ8VC5Ya/98KRBIJI=
X-Received: by 2002:a2e:9083:: with SMTP id l3mr8316414ljg.127.1573248335384;
 Fri, 08 Nov 2019 13:25:35 -0800 (PST)
MIME-Version: 1.0
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Fri, 8 Nov 2019 23:25:09 +0200
Message-ID: <CALN7hCJRe1uL6pd+VwgzDt=5giMVjvX+YpF28f5qbLOVCZf4GQ@mail.gmail.com>
Subject: Missing size_t declaration in UAPI
To:     linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,
Currently compiling the following program fails:
```
#include "linux/signal.h"
void main(void){}
```
Because of `./asm/signal.h:127:2: error: unknown type name =E2=80=98size_t=
=E2=80=99`.

I tried patching with `#include <stddef.h>` but there's a local file
with the same name overriding the include.

How can this be fixed? the `drm` headers seems to work with `uint_*`.

Right now the `linux/signal.h` header isn't usable without wrapping it
with another header to include/define size_t.

Thanks,
Elichai.

--=20
PGP: 5607C93B5F86650C
