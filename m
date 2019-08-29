Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C80A12C2
	for <lists+linux-api@lfdr.de>; Thu, 29 Aug 2019 09:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfH2HoW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Aug 2019 03:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfH2HoV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Aug 2019 03:44:21 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 715C2796FC
        for <linux-api@vger.kernel.org>; Thu, 29 Aug 2019 07:44:21 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id f11so1584590edb.16
        for <linux-api@vger.kernel.org>; Thu, 29 Aug 2019 00:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=syJ1qgGbb2nyLjAQ0BdovjtQf9fJ98FvbZ0asS0WfAc=;
        b=BpQn5923GpHpxfRKXgH7gpWcDH1OFCGpzh0EiWvYTl/6aQL0n9Bs+PXB/U8Exn4mcs
         5d0gzIiPP50ARaJig9X//W8hdqNk/3shvVOU0I0ArUZ6GbFlqrEs2NUrn0S41luueyRt
         bMtfwTQPJfVpTEpGchli6s9Wm2zEfNNN5uacpwlkntI+q6Yc0MmKixVgH6uPRWPZ+TH2
         tQi4sfRcZgHN+vxhnbSRApRlFJWPHE+8MkIcsoOIRD4E0LEsoL51EUF/jecHgEXrEZ+E
         yRzywIbQoMEu9TT06NkNN25aDXeljMnRWkTTK5OglQ3nCf+AzYY8kYuDAbgjf9tqjUdq
         DTRA==
X-Gm-Message-State: APjAAAVqgK+waTZ0KzhEKW34Ldt+igRaIiXYfyz26oCq58qtCmbg8Ata
        XjrHi/PVBTvnQNba0+TOqOwXDYGRABfmq7S4DBGJA9e2M+MlBLNfVLvExkWRa3PTIlDM0p2xHXi
        wHEUzJVVqDl3xGO+uiZF8
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr6877700ejx.181.1567064660256;
        Thu, 29 Aug 2019 00:44:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTEgOTmPL7C6gKeK+p4p3VDmj4jaAlWchwY4AG0qidGcwqilr8Hiqay9Scqq+u8hizc7+f4A==
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr6877690ejx.181.1567064660112;
        Thu, 29 Aug 2019 00:44:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h9sm292089edv.75.2019.08.29.00.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 00:44:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7C1F2181C2E; Thu, 29 Aug 2019 09:44:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>, luto@amacapital.net
Cc:     davem@davemloft.net, peterz@infradead.org, rostedt@goodmis.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 1/3] capability: introduce CAP_BPF and CAP_TRACING
In-Reply-To: <20190829051253.1927291-1-ast@kernel.org>
References: <20190829051253.1927291-1-ast@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Aug 2019 09:44:18 +0200
Message-ID: <87ef14iffx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Alexei Starovoitov <ast@kernel.org> writes:

> CAP_BPF allows the following BPF operations:
> - Loading all types of BPF programs
> - Creating all types of BPF maps except:
>    - stackmap that needs CAP_TRACING
>    - devmap that needs CAP_NET_ADMIN
>    - cpumap that needs CAP_SYS_ADMIN

Why CAP_SYS_ADMIN instead of CAP_NET_ADMIN for cpumap?

-Toke
