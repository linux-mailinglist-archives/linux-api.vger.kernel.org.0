Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B6856BA
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfHHAHZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:07:25 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55292 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfHHAHZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:07:25 -0400
Received: by mail-pg1-f201.google.com with SMTP id m17so47628056pgh.21
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RA/AzJFbqTTjRNhYxA2E49Vb11Ruh+1EJHlxTueWjTY=;
        b=X3UXrNScaPGXcZrnUuHWqeCsi+0ba/hy6lA/tcRliqPEmv+PCWNVtiZ5NkTmWRUfWA
         FYXYef5PqQjgWqrA3Vaq3/yl3c8J7zWfN2qotCd+nXliqQ0i2psj1dpndL8y7vdKF+12
         7Xdr5s9Ea5Ci5KdN7azDmW5TRUnbHfuG8I9c+AoBKB+RvTfY0yQYbFsWBLDqu3GrLghj
         K9sj1BzMDrefvide68vZUJ3BlYFn9ABSac6mhMP7CVWcsO7Jn6iE8Z3HoDCZh+hAhNYD
         b88UuaMB7nNjBacqWnqCnGNoSLoe+/NjjX1GBfsvhrMfYpU2PccJW3YGI9FjR6URUeMu
         zzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RA/AzJFbqTTjRNhYxA2E49Vb11Ruh+1EJHlxTueWjTY=;
        b=fF0AmRqyC8dNVnbb1TjJunvj1Mki9yL+mwg/313Qs1+OmVGzDBkO2nKTPZhQMeFyUj
         ljLAvV4Q9a7ZF+/oBWFdie9xsKly7DBEkUZfz6DkgjaGJ0OlWegSrrr7X/7S+TRPbxIP
         fG5wyGJ2fR8of6PfASZEGDXGOAw0Qnaos9KdXKhjwhW+791xIlo49EIpczKR+El/E3hi
         sRMM3Qn/gVJgWwpxfBtGo4hBQBRhcCbSpJHsszd/dmv/SXht0luGsSnky/eCxdiUsxRw
         U99kwiZZdYAQRlIf67Dg0XMj5dp2WECrAwQc+/AjyMJb32XJpyH/antFuU6tlPlVKFBW
         EsEQ==
X-Gm-Message-State: APjAAAUAsaUclYaWVcd6gE/LsM0BupObb74Eq01HOq5e3asX8h05/FZ4
        trKB1xlRxKed4hEPlKjh/Ep5c5eeP/Y3xJTjci7zcw==
X-Google-Smtp-Source: APXvYqxt5HteYlNYSyG0H4Bdm+j8ER0YvN1NzjCzMXnO3nx4gpqpTHXi3q+FUGWL6wetdciOWJ3PzX6gavYgbpYrXeQlmg==
X-Received: by 2002:a65:6096:: with SMTP id t22mr8991690pgu.204.1565222844769;
 Wed, 07 Aug 2019 17:07:24 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:52 -0700
Message-Id: <20190808000721.124691-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 00/29] security: Add support for locking down the kernel
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Fixed an unused function parameter in patch 19, otherwise identical to
V37.


