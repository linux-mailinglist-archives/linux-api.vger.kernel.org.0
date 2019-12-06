Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6421156E4
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 19:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLFSAW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 13:00:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36252 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLFSAW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 13:00:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id s25so2259424qks.3
        for <linux-api@vger.kernel.org>; Fri, 06 Dec 2019 10:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=P3LTWZSy3wKY6Vq6kTnLV1Tg9rnX8ii3T/WLf2zHvfQ=;
        b=kI0cWx5NuSFo5k3faOPPdQI0tSENAiIOy+0iW1MIzFCOFEvQw8Elx6iYtXcEDSfNyL
         Gtu+YAXP5mow0XNbpLBkfILQkn0RTJ9EoHgohP/SlgxhcMGmYKq1ctN5S4fYYAVUaWyg
         z4cV0LVDRK2PmjmUFKJPP3NlnU3E2pAYOOhq6q+dBXtuFU7AqfhtujGxf02k0dPjxi/y
         hL+AhKRrNnvH2DNIYYcAfDEZJrfXtIDfZsK7NBHxKYCNVK/2Ie/m9PEnKGclC/QstxZd
         us/75WT+kEtMKAYY8kA8s7aJWQNBgKhcNVbihGh9ctxBM9XgYEickxDgjV4ChkE8qZMI
         86jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=P3LTWZSy3wKY6Vq6kTnLV1Tg9rnX8ii3T/WLf2zHvfQ=;
        b=Tops+ZZFtw1PUSdPGkbMAdexlpNq72wJy8aAWvb9484LmOD/U0qdk055cwR/mch95t
         0mrM7mACbkVVG2rlNjANpO4bVH0rpP4k1XVXzigo6HN0z+iDk7uH6/bl+TX3iJ6C4uNP
         s5wynLOstKDHxGYKajXOpj3PzpafY8oKh1/lFyCqiVecD49+K47s8SpgaSn88LhgJ0QZ
         YXU3fna/kepEwGXrIVOL0UaqeHE3Y5s5wqV4pHHts6qDttx+DDujCxEhZWCbTShCpiBP
         5uTn2IQQDmKT2VHdwPytcngXRE0q35wFbW1HYoFiOoYkQHx/whIlt+0U4GJyuyJpefsm
         kYbw==
X-Gm-Message-State: APjAAAVTwUNJp5LvAZO8A1c3GGUALzOn5CHtiaYQoL16Rc7Ose9OeIuW
        IvzhINQFRKcGCOl+3Ji9rpiajA==
X-Google-Smtp-Source: APXvYqwP+gBo+6PfKaigR1Kw07O69ViABs/txMEDMfngJPHE5IHMuZN320HNB8zHCAjZM2YVbHEZyw==
X-Received: by 2002:a05:620a:101b:: with SMTP id z27mr14239078qkj.241.1575655220899;
        Fri, 06 Dec 2019 10:00:20 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p3sm6001073qkf.107.2019.12.06.10.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 10:00:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already on the target nodes
Date:   Fri, 6 Dec 2019 13:00:18 -0500
Message-Id: <BE1B9B9B-17C2-4093-A332-183DF3B6F2A3@lca.pw>
References: <5384814f-c937-9622-adbe-c03e199e0267@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>, mtk.manpages@gmail.com,
        cl@linux.com, akpm@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5384814f-c937-9622-adbe-c03e199e0267@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Dec 6, 2019, at 12:31 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>=20
> It looks since commit e78bbfa82624 ("mm: stop returning -ENOENT from sys_m=
ove_pages() if nothing got migrated") too, which reset err to 0 unconditiona=
lly. It seems it is on purpose by that commit the syscall caller should chec=
k status for the details according to the commit log.

I don=E2=80=99t read it on purpose. =E2=80=9CThere is no point in returning -=
ENOENT from sys_move_pages() if all pages
were already on the right node=E2=80=9D, so this is only taking about the pa=
ges in the desired node. Anyway, but now it is probably the best time to thi=
nk outside the box redesigning this syscalls and nuke this whole mess.=
