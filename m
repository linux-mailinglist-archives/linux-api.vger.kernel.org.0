Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D927B69C37
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfGOT7y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 15:59:54 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55352 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbfGOT7x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 15:59:53 -0400
Received: by mail-pg1-f202.google.com with SMTP id z14so4108147pgr.22
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OVQw66IG1TeMxfp3qBGrO0Nq5KpRlHDYY3Tp9RJoAOQ=;
        b=Z40FzhiN7QkHIcm/x7gDZHaqhdbVO47xKXmIio3X9TEl7ZUHg90pEn4lcoqCG0D9+n
         mdAXwlxahi+fq0F/hSMkqYP25JZ+J/7ULdCc2Pv2E9Zm8mpBNodj9X65rUwGA50KJFKZ
         8ndCz1zbYqQ1LlHxearlu6JmCtz8AC0c2NxO8Ne3yMHNTHpr5kRxQ0SytQLChXYOKbyl
         7xpf/XXqa6bmJcDLZSKOHYPkH4so0+jl2lZOyrSGHRvgZzklAqXaFL+UG465c98cXhbY
         7hnsthwoJm4iPXB0NbkdrrQubHduIV1aL6zKunghD6eZl69UQlg1rzqAuqQxcsuW8Cr/
         IF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OVQw66IG1TeMxfp3qBGrO0Nq5KpRlHDYY3Tp9RJoAOQ=;
        b=gavjDEoeAHtxj9N7qNu57lzZmLt/1d0mKDNBoTZCCL7v7DzT5jZOd7XAW7WFmIqg6c
         y8lX84Saf/oMtUxvCQJdlEYQbrMtWDEJtfO9lzhbkhUGJyk3zigCaoxXJTbA/B9dh4XS
         g+aK8D8VBYcc8w3XGmbPsBYtibQZfKJThQEcEcJt25l4+kjn1LN+uJhGUj99/8T6wZji
         ucikuZgv/V9h9AH/XTxoQMcSLSkRzpf0Kp/4/pHYWqNPZ+L7DP+r8qHryoyeu2H+8w5k
         Z3Ue8W2E90C/ja3bDzQJxY8R5XnFOCw+szWHeIv18bed4x0QBhOv35GAn2GDz4zo5eGP
         Rd7A==
X-Gm-Message-State: APjAAAUy37eNQnG5XHbaouLucPYzXghK84iiQwWYnManXYpNqvl7fm7c
        ScPsvcO5EVlhA5i9V7z0cxpq2o3nGE6k3sd1LlAing==
X-Google-Smtp-Source: APXvYqwcpVzkeCXm6tbCeVNWzSBQUBVwsOErkSfLJInKW26yH5Uxxr2SMb/+OqxhgHFmgFPBQ448BNZj2m/5sN2/HVk81g==
X-Received: by 2002:a65:614a:: with SMTP id o10mr28000193pgv.407.1563220792933;
 Mon, 15 Jul 2019 12:59:52 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:17 -0700
Message-Id: <20190715195946.223443-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 00/29] Kernel lockdown functionality
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Minor updates to the previous patchset to take some review comments into
account - no significant changes in functionality, other than that the
eBPF patch now only disables the kernel read functions as requested.


